---
name: testafize
description: Bootstrap a new Python project with the testafize template (uv + ruff/bandit/vulture/refurb/ty/pytest + uv audit pipeline). Use when asked to set up, create, or initialize a new Python project with testafize.
---

# testafize

Bootstrap a new Python project: uv package layout plus a static test
pipeline (ruff, bandit, vulture, refurb, ty, pytest, uv audit). The
template is one Makefile plus a pyproject.toml tool-config snippet.

## Prerequisites

- `uv` >= 0.12 (`uv --version`); the audit/malware-check preview flags need it
- network access to raw.githubusercontent.com, or a local clone (e.g. ~/w/testafize)

## New project named `{{name}}`

```bash
mkdir -p "{{name}}" && cd "{{name}}"
wget -q https://raw.githubusercontent.com/brian-learns/testafize/main/Makefile
make init
curl -s https://raw.githubusercontent.com/brian-learns/testafize/main/pyproject_tool.toml >> pyproject.toml
```

- Create the directory with the FINAL name first: uv derives the package
  name and entry point from the directory name.
- `make init` = dep check -> `uv init --package .` ->
  `uv add --dev ruff bandit vulture refurb ty pytest`. It creates
  pyproject.toml, uv.lock, .python-version, README.md,
  src/{{name}}/__init__.py, .git, .gitignore, .venv.
- The curl step appends [tool.ruff]/[tool.bandit]/[tool.ty]/[tool.uv]
  config. NEW projects only: if pyproject.toml already has any [tool.*]
  table, merge the snippet by hand — duplicate TOML tables break every tool.

## Verify

```bash
make check        # all static tools must pass
uv run {{name}}   # prints "Hello from {{name}}!"
make test         # EXPECTED to fail: pytest Error 5 "no tests ran"
                  # until tests exist; not a real failure
```

## Existing project

`make init` skips `uv init` when pyproject.toml exists and only adds the dev
tools. Merge pyproject_tool.toml by hand.

## Troubleshooting

- Project inside an outer git repo (e.g. ~/.git at the home root): `uv init`
  detects the outer repo and won't write a local .gitignore/.git. Run
  `GIT_CEILING_DIRECTORIES=$HOME make init` — the ceiling dir and everything
  above it is excluded from uv's git search; it must be an ANCESTOR of the
  project dir (a value equal to the cwd is a no-op).
- uv too old (preview-flag / audit errors): install uv >= 0.12.
