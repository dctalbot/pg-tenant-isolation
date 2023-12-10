from typing import Any, Optional, Union

from starlette.requests import HTTPConnection, Request
from starlette_context.plugins import Plugin


class TenantIdPlugin(Plugin):
    key = "tenant_id"

    async def process_request(
        self, request: Union[Request, HTTPConnection]
    ) -> Optional[Any]:
        return request.headers.get("X-tenant-id")
