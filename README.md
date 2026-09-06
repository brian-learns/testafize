# testafize
boot strap a new project or migrate an old one into modern uv setup with tests

## Prerequsites 
[install `uv`](https://docs.astral.sh/uv/getting-started/installation/)

## Initialize Test Suite

### New Project

```bash
mkdir newproject
cd newproject/
wget -q https://raw.githubusercontent.com/brian-learns/testafize/main/Makefile
make init
curl https://raw.githubusercontent.com/brian-learns/testafize/main/pyproject_tool.toml >> pyproject.toml
```

Then you will have stub python project set up with uv and static tests installed.
```bash
$ uv run newproject
Hello from newproject!
$ tree -a -I .venv/ -I .git/
.
├── .gitignore
├── Makefile
├── pyproject.toml
├── .python-version
├── README.md
├── src
│   └── newproject
│       └── __init__.py
└── uv.lock

3 directories, 7 files
```
Then you can run 
```
make check
```
to run the static tests.  There is also a stub to run pytest.

```
make test # will fail because there are no tests yet
```


### Existing Project

```bash
wget -q https://raw.githubusercontent.com/brian-learns/testafize/main/Makefile
make init
make check
```

`make init` skips `uv init` if `pyproject.toml` already exists and only adds the dev tools. To get the tool configuration, merge `pyproject_tool.toml` in by hand — do not append it, duplicate `[tool.*]` tables break every tool.

If the project sits inside an outer git repo (e.g. `~/.git` at the home root), `uv init` won't write a local `.gitignore`. Override with `GIT_CEILING_DIRECTORIES=$HOME make init` (the value must be an ancestor of the project dir).

## Analysis and Linting

* [`ruff` An extremely fast Python linter and code formatter](https://docs.astral.sh/ruff/)
* [`bandit` AST based security scanner](https://bandit.readthedocs.io/en/latest/)
* [`vulture` Find dead Python code](https://github.com/jendrikseipp/vulture)
* [`refurb` A tool for refurbishing and modernizing Python codebases](https://github.com/dosisod/refurb)
* [`ty`An extremely fast Python type checker and language server](https://docs.astral.sh/ty/)

You can uncomment `interrogate` to check for docstring coverage, but the `uv init` stubs don't pass this
* #[`interrogate` Interrogate a codebase for docstring coverage](https://interrogate.readthedocs.io/en/latest/) (commented out)


