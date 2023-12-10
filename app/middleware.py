from typing import Any, Optional, Union

from starlette.requests import HTTPConnection, Request
from starlette_context.plugins import Plugin
from starlette.middleware import Middleware
from starlette_context.middleware import RawContextMiddleware


class TenantIdPlugin(Plugin):
    key = "tenant_id"

    async def process_request(
        self, request: Union[Request, HTTPConnection]
    ) -> Optional[Any]:
        # Get the tenant ID from the request context.
        # TODO source this value securely from an authorization token, not a public HTTP header :)
        return request.headers.get("X-tenant-id")


middleware = [
    Middleware(
        RawContextMiddleware,
        plugins=(TenantIdPlugin(),),
    )
]
