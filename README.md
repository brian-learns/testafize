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
make check
uv run newproject
```
the last command outputs
```
Hello from newproject!
```

### Existing Project

```bash
wget -q https://raw.githubusercontent.com/brian-learns/testafize/main/Makefile
make init
make check
```

## Analysis and Linting

* [`ruff` An extremely fast Python linter and code formatter](https://docs.astral.sh/ruff/)
* [`bandit` AST based security scanner](https://bandit.readthedocs.io/en/latest/)
* [`vulture` Find dead Python code](https://github.com/jendrikseipp/vulture)
* [`refurb` A tool for refurbishing and modernizing Python codebases](https://github.com/dosisod/refurb)

You can uncomment `interrogate` to check for docstring coverage, but the `uv init` stubs don't pass this
* #[`interrogate` Interrogate a codebase for docstring coverage](https://interrogate.readthedocs.io/en/latest/) (commented out)


