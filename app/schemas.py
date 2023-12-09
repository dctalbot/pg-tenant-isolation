from uuid import UUID

from pydantic import BaseModel

class Item(BaseModel):
    id: UUID
    title: str
    tenant_id: UUID

    class Config:
        orm_mode = True

class TenantBase(BaseModel):
    id: UUID
    name: str
    items: list[Item] = []

    class Config:
        orm_mode = True
