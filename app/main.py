from fastapi import Depends, FastAPI


from . import schemas, store
from .db import db, get_session
from .middleware import middleware

# stand up the web server
# the middleware attaches the tenant ID to the request context
app = FastAPI(middleware=middleware)

# initialize the sqlalchemy integration
db.init_app(app)


@app.get("/tenants/", response_model=list[schemas.Tenant])
def get_tenants_tenants(session=Depends(get_session)):
    return store.get_tenants(session)


@app.get("/items/", response_model=list[schemas.Item])
def get_items(session=Depends(get_session)):
    return store.get_items(session)
