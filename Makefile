.PHONY: venv
venv:
	python -m venv .venv
	. .venv/bin/activate; pip --require-virtualenv install -r requirements.txt
	. .venv/bin/activate; pip --require-virtualenv check

.PHONY: pg
pg:
	docker run --rm --name pg-tenant-isolation-demo -e POSTGRES_PASSWORD=postgres -d -p 5432:5432 -v ./init.sql:/docker-entrypoint-initdb.d/init.sql postgres

.PHONY: pg-logs
pg-logs:
	docker logs -f pg-tenant-isolation-demo

.PHONY: start
start:
	. .venv/bin/activate; uvicorn app.main:app --reload

.PHONY: stop
stop:
	docker stop pg-tenant-isolation-demo

.PHONY: clean
clean:
	docker stop pg-tenant-isolation-demo
	rm -rf .venv

.PHONE: lint
lint:
	. .venv/bin/activate; ruff . --fix
	. .venv/bin/activate; ruff format .
