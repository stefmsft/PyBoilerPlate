#!/bin/bash

# Python Boilerplate Setup Script
# This script installs uv and sets up a Python development environment

set -e  # Exit on any error

echo "🚀 Setting up Python development environment with uv..."

# Check if uv is already installed
if command -v uv &> /dev/null; then
    echo "✅ uv is already installed"
else
    echo "📦 Installing uv..."
    # Install uv using the official installer
    curl -LsSf https://astral.sh/uv/install.sh | sh
    
    # Add uv to PATH for current session
    export PATH="$HOME/.cargo/bin:$PATH"
    
    # Verify installation
    if command -v uv &> /dev/null; then
        echo "✅ uv installed successfully"
    else
        echo "❌ Failed to install uv"
        exit 1
    fi
fi

# Check if we're in an existing project or need to refresh
if [ -f "pyproject.toml" ] && [ -d "src" ]; then
    echo "🔄 Existing project detected. Refreshing..."
    
    # Remove existing virtual environment if it exists
    if [ -d ".venv" ]; then
        echo "🗑️  Removing existing virtual environment..."
        rm -rf .venv
    fi
    
    # Clean up any cached files
    find . -name "__pycache__" -type d -exec rm -rf {} + 2>/dev/null || true
    find . -name "*.pyc" -delete 2>/dev/null || true
else
    echo "🆕 Setting up new project structure..."
fi

# Create virtual environment and install dependencies
echo "🔧 Creating virtual environment and installing dependencies..."
uv sync

# Activate virtual environment and show Python version
echo "🐍 Virtual environment ready!"
echo "To activate the environment, run: source .venv/bin/activate (Linux/Mac) or .venv\Scripts\activate (Windows)"

# Show installed packages
echo "📦 Installed packages:"
uv pip list

echo "✨ Setup complete! Your Python development environment is ready."
echo "🧪 Run tests with: uv run pytest"
echo "🚀 Start developing in the src/MyModule directory"