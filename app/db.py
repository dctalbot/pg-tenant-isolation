from __future__ import annotations

from typing import TYPE_CHECKING, Any, Union
from uuid import UUID

import sqlalchemy as sa
from sqlalchemy import create_engine, event
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import (
    scoped_session,
    sessionmaker,
)
from starlette_context import context as ctx

if TYPE_CHECKING:
    from fastapi import FastAPI
    from psycopg2 import cursor as DBAPICursor  # type: ignore[attr-defined]
    from sqlalchemy.engine import ExecutionContext
    from sqlalchemy.future import Connection


DATABASE_URL = "postgresql://web_app_user:postgres@localhost/postgres"


class FastAPISQLAlchemyDB:
    """
    This class provides an integration for FastAPI and SQLAlchemy.

    - Postgres RLS permissions are set per query.
    """

    def __init__(self) -> None:
        self.engine = create_engine(DATABASE_URL)
        self.Base = declarative_base(metadata=sa.MetaData())
        self.session = scoped_session(
            sessionmaker(autocommit=False, autoflush=False, bind=self.engine)
        )
        self.Base.session = self.session  # type: ignore[attr-defined]
        self.Base.query = self.session.query_property()  # type: ignore[attr-defined]

    def init_app(self, app: FastAPI) -> None:
        """
        Establish the intergation points between Flask and SQLAlchemy.
        """

        @event.listens_for(self.engine, "before_cursor_execute", retval=True)
        def receive_before_cursor_execute(
            _conn: Connection,
            _cur: DBAPICursor,
            statement: str,
            parameters: Union[Any, None],
            _ctx: Union[ExecutionContext, None],
            _executemany: bool,
        ) -> tuple[str, Any]:
            """
            Set the RLS session parameters by packing them into each SQL statement.
            """
            rls_statement = self._get_session_params_sql(
                tenant_id=UUID(ctx["tenant_id"])
            )
            statement = rls_statement + statement
            return statement, parameters

    def _get_session_params_sql(self, tenant_id: UUID) -> str:
        """
        Generate the SQL to SET the session parameters for Postgres RLS.
        SQL injection is avoided by using the psycopg2 mogrify method.
        """
        cursor: DBAPICursor = self.engine.raw_connection().cursor()  # type: ignore[assignment]
        result = cursor.mogrify(
            "SET app.current_tenant_id = %s;",
            (str(tenant_id),),
        )
        return result.decode("utf-8")


db = FastAPISQLAlchemyDB()


def get_session():
    yield db.Base.session
    try:
        yield db.Base.session
    finally:
        db.Base.session.close()
