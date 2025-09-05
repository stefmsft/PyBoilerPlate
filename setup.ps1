#!/usr/bin/env pwsh

# Python Boilerplate Setup Script
# This script installs uv and sets up a Python development environment

# Set strict mode to exit on any error
$ErrorActionPreference = "Stop"

Write-Host "🚀 Setting up Python development environment with uv..." -ForegroundColor Green

# Check if uv is already installed
try {
    $uvVersion = uv --version 2>$null
    Write-Host "✅ uv is already installed ($uvVersion)" -ForegroundColor Green
} catch {
    Write-Host "📦 Installing uv..." -ForegroundColor Yellow
    
    # Install uv using the official PowerShell installer
    try {
        Invoke-RestMethod -Uri "https://astral.sh/uv/install.ps1" | Invoke-Expression
        
        # Refresh PATH for current session
        $env:PATH = [System.Environment]::GetEnvironmentVariable("PATH", "User") + ";" + [System.Environment]::GetEnvironmentVariable("PATH", "Machine")
        
        # Verify installation
        $uvVersion = uv --version 2>$null
        Write-Host "✅ uv installed successfully ($uvVersion)" -ForegroundColor Green
    } catch {
        Write-Host "❌ Failed to install uv" -ForegroundColor Red
        Write-Host "Please install uv manually from https://docs.astral.sh/uv/getting-started/installation/" -ForegroundColor Red
        exit 1
    }
}

# Check if we're in an existing project or need to refresh
if ((Test-Path "pyproject.toml") -and (Test-Path "src")) {
    Write-Host "🔄 Existing project detected. Refreshing..." -ForegroundColor Yellow
    
    # Remove existing virtual environment if it exists
    if (Test-Path ".venv") {
        Write-Host "🗑️  Removing existing virtual environment..." -ForegroundColor Yellow
        Remove-Item -Path ".venv" -Recurse -Force
    }
    
    # Clean up any cached files
    Write-Host "🧹 Cleaning up cached files..." -ForegroundColor Yellow
    Get-ChildItem -Path . -Recurse -Name "__pycache__" -ErrorAction SilentlyContinue | ForEach-Object {
        Remove-Item -Path $_ -Recurse -Force -ErrorAction SilentlyContinue
    }
    Get-ChildItem -Path . -Recurse -Filter "*.pyc" -ErrorAction SilentlyContinue | Remove-Item -Force -ErrorAction SilentlyContinue
} else {
    Write-Host "🆕 Setting up new project structure..." -ForegroundColor Yellow
}

# Create virtual environment and install dependencies
Write-Host "🔧 Creating virtual environment and installing dependencies..." -ForegroundColor Yellow
try {
    uv sync
} catch {
    Write-Host "❌ Failed to sync dependencies. Make sure you have a valid pyproject.toml file." -ForegroundColor Red
    exit 1
}

# Show virtual environment info
Write-Host "🐍 Virtual environment ready!" -ForegroundColor Green
Write-Host "To activate the environment, run: .venv\Scripts\Activate.ps1 (PowerShell) or .venv\Scripts\activate.bat (Command Prompt)" -ForegroundColor Cyan

# Show installed packages
Write-Host "📦 Installed packages:" -ForegroundColor Yellow
try {
    uv pip list
} catch {
    Write-Host "Could not list packages. Virtual environment may not be properly configured." -ForegroundColor Red
}

Write-Host "✨ Setup complete! Your Python development environment is ready." -ForegroundColor Green
Write-Host "🧪 Run tests with: uv run pytest" -ForegroundColor Cyan
Write-Host "🚀 Start developing in the src/MyModule directory" -ForegroundColor Cyan

# Handle git repository initialization
Write-Host ""
if (Test-Path ".git") {
    Write-Host "🔍 Git repository detected." -ForegroundColor Yellow
    Write-Host "⚠️  To use this as a new project, you should remove the boilerplate git history." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Options:" -ForegroundColor White
    Write-Host "  1. Remove git history and start fresh (git init)" -ForegroundColor White
    Write-Host "  2. Remove git history, no git init (for git clone later)" -ForegroundColor White
    Write-Host "  3. Keep current git history" -ForegroundColor White
    Write-Host "  4. Skip for now (you can run this script again later)" -ForegroundColor White
    Write-Host ""
    $gitChoice = Read-Host "Choose option (1/2/3/4)"
    
    switch ($gitChoice) {
        "1" {
            Write-Host "🗑️  Removing boilerplate git history..." -ForegroundColor Yellow
            Remove-Item -Path ".git" -Recurse -Force -ErrorAction SilentlyContinue
            Write-Host "🆕 Initializing new git repository..." -ForegroundColor Green
            git init
            git add .
            Write-Host "📝 Ready for your initial commit!" -ForegroundColor Green
            Write-Host "    Run: git commit -m 'Initial commit'" -ForegroundColor Cyan
            Write-Host "    Then add your remote: git remote add origin <your-repo-url>" -ForegroundColor Cyan
        }
        "2" {
            Write-Host "🗑️  Removing boilerplate git history..." -ForegroundColor Yellow
            Remove-Item -Path ".git" -Recurse -Force -ErrorAction SilentlyContinue
            Write-Host "📝 Ready for git clone! You can now:" -ForegroundColor Green
            Write-Host "    git clone <your-repo-url> ." -ForegroundColor Cyan
            Write-Host "    Or initialize later with: git init" -ForegroundColor Cyan
        }
        "3" {
            Write-Host "✅ Keeping current git history." -ForegroundColor Green
        }
        "4" {
            Write-Host "⏭️  Skipped git setup. You can run this script again later." -ForegroundColor Yellow
        }
        default {
            Write-Host "❓ Invalid choice. Skipping git setup." -ForegroundColor Red
        }
    }
} else {
    Write-Host "📝 No git repository found. You can:" -ForegroundColor Yellow
    Write-Host "    Initialize: git init && git add . && git commit -m 'Initial commit'" -ForegroundColor Cyan
    Write-Host "    Or clone: git clone <your-repo-url> ." -ForegroundColor Cyan
}