from sqlalchemy import Column, ForeignKey, String, UUID
from sqlalchemy.orm import relationship

from .db import Base


class Tenant(Base):
    __tablename__ = "tenants"

    id = Column(UUID, primary_key=True)
    name = Column(String, nullable=False, unique=True)

    items = relationship("Item", back_populates="tenant")


class Item(Base):
    __tablename__ = "items"

    id = Column(UUID, primary_key=True, index=True)
    title = Column(String, nullable=False)
    description = Column(String, nullable=False)
    tenant_id = Column(UUID, ForeignKey("tenants.id"), nullable=False)

    tenant = relationship("Tenant", back_populates="items")
