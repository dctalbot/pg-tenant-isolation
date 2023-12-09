.PHONY: deps
deps:
	python -m venv .venv
	. .venv/bin/activate; pip --require-virtualenv install -r requirements.txt
	. .venv/bin/activate; pip --require-virtualenv check

.PHONY: start
start:
	. .venv/bin/activate; uvicorn main:app --reload
