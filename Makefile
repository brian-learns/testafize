.PHONY: help check test clean testpackages

help:
	@echo ""
	@echo "  make check      Run ultra-fast static testing pipeline (ruff, bandit, vulture, etc.)"
	@echo "  make test       Run static checks followed immediately by pytest"
	@echo "  make clean      Wipe out test tool cache tracking footprints"
	@echo "  make init       Initialize new project with uv and test setup"

check:
	@echo "\n— [An extremely fast Python linter and code formatter](https://docs.astral.sh/ruff/)"
	uv run ruff check src/ --fix
	uv run ruff format src/ --check

	@echo "\n— [AST based security scanner](https://bandit.readthedocs.io/en/latest/)"
	uv run bandit -c pyproject.toml -r src/

	@echo "\n— [Find dead Python code](https://github.com/jendrikseipp/vulture)"
	uv run vulture src/ --min-confidence 80

	@echo "\n— [A tool for refurbishing and modernizing Python codebases](https://github.com/dosisod/refurb)"
	uv run refurb src/

	@echo "\n— [An extremely fast Python type checker and language server]( https://docs.astral.sh/ty/)"
	uv run ty check src/

	@echo "\n— [Interrogate a codebase for docstring coverage](https://interrogate.readthedocs.io/en/latest/)"
	#uv run interrogate src/

test: check
	uv run pytest -v --durations=5

clean:
	rm -rf .pytest_cache .ruff_cache .mypy_cache .vulture_cache .uv
	find . -type d -name "__pycache__" -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete

init: pyproject.toml testpackages

testpackages:
	uv add --dev ruff bandit vulture refurb ty pytest #interrogate

export GIT_CEILING_DIRECTORIES	# can influence `uv init` behaviour
pyproject.toml:
	uv init --package .
