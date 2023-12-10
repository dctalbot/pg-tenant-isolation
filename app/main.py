from fastapi import Depends, FastAPI
from starlette.middleware import Middleware
from starlette_context import plugins
from starlette_context.middleware import RawContextMiddleware

from . import schemas, store
from .db import db, get_session
from .middleware import TenantIdPlugin

middleware = [
    Middleware(
        RawContextMiddleware,
        plugins=(
            plugins.RequestIdPlugin(),
            plugins.CorrelationIdPlugin(),
            TenantIdPlugin(),
        ),
    )
]

app = FastAPI(debug=True, middleware=middleware)
db.init_app(app)


@app.get("/tenants/", response_model=list[schemas.Tenant])
def get_tenants_tenants(session=Depends(get_session)):
    return store.get_tenants(session)


@app.get("/items/", response_model=list[schemas.Item])
def get_items(session=Depends(get_session)):
    return store.get_items(session)
