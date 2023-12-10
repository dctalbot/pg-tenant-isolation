from sqlalchemy.orm import Session

from . import models


def get_items(session: Session):
    return session.query(models.Item).all()


def get_tenants(session: Session):
    return session.query(models.Tenant).all()
