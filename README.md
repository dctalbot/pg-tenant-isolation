# Multi-tenant data isolation with PostgreSQL and SQLAlchemy

# Getting Started

Requirements:

- Python 3.9.13
- Docker 24.0.6

1. Install python dependencies

```
make venv
```

2. Start postgres server in docker container with seed data

```
make pg
```

3. Start the web server

```
make start
```

```
make clean
```

```console
curl --header "X-tenant-id: 7a245486-3fc8-47ec-b303-04fefe7a58ff" http://127.0.0.1:8000/items/ | jq
[
  {
    "id": "997d0bee-351f-4b09-9dd3-2289da1ce0ba",
    "title": "art-fair",
    "tenant_id": "7a245486-3fc8-47ec-b303-04fefe7a58ff"
  },
  {
    "id": "bab62059-b702-442e-a053-7e4690d5510b",
    "title": "bench",
    "tenant_id": "7a245486-3fc8-47ec-b303-04fefe7a58ff"
  },
  {
    "id": "1bfa0393-0f74-4824-b234-052e49511a5c",
    "title": "concert",
    "tenant_id": "7a245486-3fc8-47ec-b303-04fefe7a58ff"
  },
  {
    "id": "1b94d748-6241-410c-95f5-015105316f27",
    "title": "drinking-fountain",
    "tenant_id": "7a245486-3fc8-47ec-b303-04fefe7a58ff"
  },
  {
    "id": "de5de5ab-abdd-499a-95a6-00f8c7b7130a",
    "title": "emergency-kit",
    "tenant_id": "7a245486-3fc8-47ec-b303-04fefe7a58ff"
  }
]
```
