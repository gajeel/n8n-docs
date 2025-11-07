# Dev Container for n8n-docs

This folder contains configuration to run the repository inside a VS Code Dev Container.

Files included:
- `devcontainer.json` — configuration that builds the container using the supplied `Dockerfile`.
- `Dockerfile` — base image with Python 3 and Node 20 plus common build tools.
- `postCreate.sh` — script run after the container is created to install Python/Node dependencies and dev tooling.
- `docker-compose.yml` — optional compose file for local Docker workflows.

Quick start
1. Open the repository in VS Code.
2. From the Command Palette choose: "Dev Containers: Reopen in Container".
3. The container will build, then run `postCreate.sh`.
4. If you use Sphinx or MkDocs, ensure `requirements.txt` includes the packages or rely on the default tools installed by `postCreate.sh`.
5. Run your documentation server, e.g. `mkdocs serve -a 0.0.0.0:8000` or `sphinx-autobuild docs docs/_build/html --port 8000` and access it at http://localhost:8000

Notes
- The `postCreate.sh` script prefers using your `requirements.txt` and `package.json` when present to keep project dependencies explicit.
- If you want additional system packages or a different Python version, modify the `Dockerfile`.