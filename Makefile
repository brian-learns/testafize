.PHONY: help check test clean testpackages

help:
	@echo ""
	@echo "  make check      Run ultra-fast static testing pipeline (ruff, bandit, vulture, etc.)"
	@echo "  make test       Run static checks followed immediately by pytest"
	@echo "  make clean      Wipe out test tool cache tracking footprints"
	@echo "  make init       Initialize new project with uv and test setup"

check:
	uv run ruff check src/ --fix                    # https://docs.astral.sh/ruff/
	uv run ruff format src/ --check	                # An extremely fast Python linter and code formatter

	uv run bandit -c pyproject.toml -r src/         # https://bandit.readthedocs.io/en/latest/
	                                                # AST based security scanner

	uv run vulture src/ --min-confidence 80         # https://github.com/jendrikseipp/vulture
	                                                # Find dead Python code

	uv run refurb src/                              # https://github.com/dosisod/refurb
	                                                # A tool for refurbishing and modernizing Python codebases

	#uv run interrogate src/                        # https://interrogate.readthedocs.io/en/latest/
	                                                # Interrogate a codebase for docstring coverage.

test: check
	uv run pytest -v --durations=5

clean:
	rm -rf .pytest_cache .ruff_cache .mypy_cache .vulture_cache .uv
	find . -type d -name "__pycache__" -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete

init: pyproject.toml testpackages

testpackages:
	uv add --dev ruff bandit vulture refurb pytest #interrogate

export GIT_CEILING_DIRECTORIES	# can influence `uv init` behaviour
pyproject.toml:
	uv init --package .
