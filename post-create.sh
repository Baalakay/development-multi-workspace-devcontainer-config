#!/bin/bash
set -e

echo "Setting up development environment..."

# 1. Setup ZSH plugins
echo "Setting up ZSH plugins..."
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/matthiasha/zsh-uv-env ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-uv-env

# 2. Setup dotfiles
echo "Setting up dotfiles..."
git clone https://github.com/Baalakay/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
stow --adopt .
git reset --hard
cd $LOCAL_WORKSPACE_FOLDER

# 3. Ensure .zshrc exists and set aliases
touch ~/.zshrc
if grep -q '^alias cat=' ~/.zshrc; then
  sed -i 's|^alias cat=.*|alias cat=batcat|' ~/.zshrc
else
  echo 'alias cat=batcat' >> ~/.zshrc
fi
if ! grep -q '^alias bat=batcat' ~/.zshrc; then
  echo 'alias bat=batcat' >> ~/.zshrc
fi

# 4. npm global install (if needed)
npm install -g npm@11.4.1

# # 5. Ownership fix
# ACTIVE_PROJECT="${ACTIVE_PROJECT:-$(basename "$LOCAL_WORKSPACE_FOLDER")}"
# for d in ".venv" ".mypy_cache" ".pytest_cache" "dist" "frontend/node_modules"; do
#   sudo chown -R vscode:vscode "/workspaces/$ACTIVE_PROJECT/$d" 2>/dev/null || true
# done

# 6. Project setup
PROJECT_PATH="/workspaces/$ACTIVE_PROJECT"
cd "$PROJECT_PATH"

if [ -d "frontend" ]; then
    non_node_modules=$(find frontend -mindepth 1 -maxdepth 1 ! -name node_modules)
    if [ -z "$non_node_modules" ]; then
        echo "frontend is empty (except node_modules), running create-react-router..."
        printf "n\ny\n" | npx --yes create-react-router@latest frontend
    else
        echo "frontend contains files other than node_modules, skipping create-react-router."
    fi
fi

if [ -d "frontend" ]; then
    echo "frontend folder exists, running npm install..."
    cd frontend
    npm install
    cd ..
fi

uv sync
if [ -f "requirements.txt" ]; then
    uv pip install -r requirements.txt
fi

echo "Development environment setup complete! Launch a new terminal session to begin in your devcontainer."