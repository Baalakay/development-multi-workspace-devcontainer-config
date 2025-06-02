# Global Devcontainer Configuration

This repository provides a **shared/global devcontainer setup** for use across multiple projects. It contains all configuration files, scripts, and Docker Compose setup needed to provide a consistent, reproducible development environment for Python, React, and more.

## Prerequisites
- [Docker](https://www.docker.com/) or [Docker Desktop](https://www.docker.com/products/docker-desktop/) (choose based on your OS)
- Your preferred IDE: [VS Code](https://code.visualstudio.com/), [Cursor](https://www.cursor.so/), [Windsurf](https://windsurf.ai/), etc.
- [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
- [Remote Development extension pack](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack)
- See the [official devcontainers documentation](https://containers.dev/) for more details and platform-specific setup.

## How to Use This Global Devcontainer

1. **Clone this repository somewhere accessible on your machine:**
   ```sh
   git clone https://github.com/Baalakay/development-global-devcontainer.git ~/development-global-devcontainer
   ```
2. **In each project, symlink the `.devcontainer` directory to this global repo:**
   ```sh
   cd /path/to/your/project
   ln -s ~/development-global-devcontainer .devcontainer
   ```
3. **Make the project context script executable:**
   ```sh
   chmod +x .devcontainer/set-project-root.sh
   ```
4. **Open your project in your IDE from the project root:**
   ```sh
   cursor .   # For Cursor IDE
   code .     # For VS Code
   ```
5. **Rebuild and open in devcontainer.**

## How It Works
- Each project gets its own `.devcontainer/.env` and Docker named volumes for dependencies and caches: `.venv`, `frontend/node_modules`, `.mypy_cache`, `.pytest_cache`, and `dist`.
- The `set-project-root.sh` script (run via `initializeCommand` in `devcontainer.json`) ensures the correct project context is set before the container is built.
- All devcontainer config, Dockerfiles, and scripts are managed centrally in this repo.

## Updating the Global Devcontainer
- To update the devcontainer config for all projects, update this repository and pull changes in each project as needed.
- Communicate breaking changes to all project maintainers.

## For Project Maintainers
- Reference this repository in your project README as a prerequisite for devcontainer setup.

---

For more details, see the [official devcontainers documentation](https://containers.dev/) and [VS Code documentation on devcontainers](https://code.visualstudio.com/docs/devcontainers/containers). 
