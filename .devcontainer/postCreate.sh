#!/bin/bash
set -e

echo "Running postCreate script inside devcontainer..."

# Ensure pip tools are up-to-date
python -m pip install --upgrade pip setuptools wheel

# If a requirements.txt is present in workspace, install it; otherwise install common docs/dev tools
if [ -f /workspace/requirements.txt ]; then
  echo "Installing Python requirements from requirements.txt..."
  pip install -r /workspace/requirements.txt
else
  echo "No requirements.txt found — installing common documentation and dev tools (sphinx, mkdocs, pre-commit, black, isort)..."
  pip install --no-cache-dir sphinx sphinx-rtd-theme sphinx-autobuild mkdocs mkdocs-material mkdocs-redirects pre-commit black isort
fi

# If project has package.json, install node dependencies
if [ -f /workspace/package.json ]; then
  echo "Installing Node dependencies with npm ci..."
  npm ci --prefix /workspace || npm install --prefix /workspace
fi

# Install pre-commit hooks if config exists
if command -v pre-commit >/dev/null 2>&1 && [ -f /workspace/.pre-commit-config.yaml ]; then
  echo "Installing pre-commit hooks..."
  (cd /workspace && pre-commit install) || true
fi

echo "postCreate finished. You can run your documentation server (mkdocs serve / sphinx-autobuild) on forwarded ports."