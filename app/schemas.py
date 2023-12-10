from uuid import UUID

from pydantic import BaseModel


class Item(BaseModel):
    id: UUID
    title: str
    tenant_id: UUID

    class Config:
        from_attributes = True


class Tenant(BaseModel):
    id: UUID
    name: str
    items: list[Item] = []

    class Config:
        from_attributes = True
