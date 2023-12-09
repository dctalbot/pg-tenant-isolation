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
