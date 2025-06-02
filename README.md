# Blake's Shared Devcontainer Configuration

This repository provides a robust, ready-to-use devcontainer environment for use across multiple projects. It is designed to be symlinked into any project as a shared `.devcontainer` folder, providing a consistent, reproducible setup for Python, React, and more.

> **Prerequisite:**
> You must have [Docker](https://www.docker.com/products/docker-desktop/) and an IDE such as [Cursor](https://www.cursor.so/), [Windsurf](https://windsurf.ai/), or [VS Code](https://code.visualstudio.com/) installed on your local machine before using this template. 
> - You must also install the [Dev Containers (Remote Development) extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers).
> - Cursor and Windsurf are forks of VSCode and so have built-in support for devcontainers.
> - Please install these tools first if you haven't already.
>
> See the [official devcontainers documentation](https://code.visualstudio.com/docs/devcontainers/containers) for more details and platform-specific setup.
>
> **IMPORTANT:**
> This repository is intended to be **symlinked** into each code/project folder as a shared `.devcontainer` folder. **Do not add any project-specific code, onboarding, or workflow details into the folder that contains this .devcontainer folder**
> - This repo is for global devcontainer configuration only.
> - All project-specific onboarding, code, and workflow documentation should be maintained in the individual project repository/folder.
> - This ensures a single source of truth for devcontainer setup across all projects, while keeping project code and logic separate.

---

## 🧩 Why Use a Shared Devcontainer?

- **Centralized Management**: Maintain one set of devcontainer configs for all projects.
- **Consistent Environments**: All projects use the same Docker, Compose, and feature setup.
- **Easy Updates**: Update your devcontainer setup in one place for all projects.
- **Per-Project Isolation**: Each project gets its own `.env` and Docker named volumes for dependencies and caches (`.venv`, `frontend/node_modules`, `.mypy_cache`, `.pytest_cache`, `dist/`).

---

## How to Use This Global Devcontainer

1. **Clone this repository somewhere accessible on your machine:**
cd to the path where you want the shared .devcontainer folder and configs stored (e.g. "development-devcontainer" is used below but choose your own name)
   ```sh
   cd /Users/Blake/Documents/projects/development-devcontainer
   git clone https://github.com/Baalakay/development-devcontainer-shared-config-template .
   ```
2. **In each project, symlink the `.devcontainer` directory to this global repo:**
   ```sh
   cd /path/to/your/project/folder
   ln -s ~/development-devcontainer .devcontainer
   chmod +x .devcontainer/set-project-root.sh
   ```
3. **Open your project in your IDE from the project root:**
   ```sh
   cursor .   # For Cursor IDE
   code .     # For VS Code
   ```
4. **Rebuild and open in devcontainer.**

---

## How It Works
- Each project gets its own `.devcontainer/.env` and Docker named volumes for dependencies and caches: `.venv`, `frontend/node_modules`, `.mypy_cache`, `.pytest_cache`, and `dist`.
- The `set-project-root.sh` script (run via `initializeCommand` in `devcontainer.json`) ensures the correct project context is set before the container is built.
- All devcontainer config, Dockerfiles, and scripts are managed centrally in this repo.

---

## Updating the Global Devcontainer
- To update the devcontainer config for all projects, update this repository and pull changes in each project as needed.
- Communicate breaking changes to all project maintainers.

---

## For Project Maintainers
- Reference this repository in your project README as a prerequisite for devcontainer setup.

---

For more details, see the [official devcontainers documentation](https://containers.dev/) and [VS Code documentation on devcontainers](https://code.visualstudio.com/docs/devcontainers/containers). 