.PHONY: deps
deps:
	python -m venv .venv
	. .venv/bin/activate; pip --require-virtualenv install -r requirements.txt
	. .venv/bin/activate; pip --require-virtualenv check

.PHONY: pg
pg:
	docker run --rm --name pg-tenant-isolation-demo -e POSTGRES_PASSWORD=postgres -d postgres

.PHONY: start
start:
	. .venv/bin/activate; uvicorn main:app --reload

.PHONY: clean
clean:
	docker stop pg-tenant-isolation-demo
	rm -rf .venv

.PHONE: lint
lint:
	. .venv/bin/activate; ruff . --fix
	. .venv/bin/activate; ruff format .

