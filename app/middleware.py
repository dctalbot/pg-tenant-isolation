from typing import Any, Optional, Union

from starlette.middleware import Middleware
from starlette.requests import HTTPConnection, Request
from starlette_context.middleware import RawContextMiddleware
from starlette_context.plugins import Plugin


class TenantIdPlugin(Plugin):
    key = "tenant_id"

    async def process_request(
        self, request: Union[Request, HTTPConnection]
    ) -> Optional[Any]:
        # Get the tenant ID from the HTTP request.
        # TODO get this value securely from an auth token, not a public HTTP header :)
        return request.headers.get("X-tenant-id")


middleware = [
    Middleware(
        RawContextMiddleware,
        plugins=(TenantIdPlugin(),),
    )
]
