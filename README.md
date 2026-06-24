# testafize
boot strap a new project or migrate an old one into modern uv setup with tests

## Start a new project
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
