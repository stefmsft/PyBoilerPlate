# Python Boilerplate with uv - How to Use It

This repository provides a modern Python project boilerplate using [uv](https://docs.astral.sh/uv/), a fast Python package installer and resolver. It includes everything you need to start developing a Python module with testing, coverage, and proper project structure.

## 🚀 Quick Start

### Prerequisites
- Python 3.8+ installed on your system
- Git (for version control)

### Setup Process

1. **Clone or copy this boilerplate** to your new project directory
2. **Run the setup script** for your platform:

**Linux/macOS:**
```bash
cd your-new-project
./setup.sh
```

**Windows (PowerShell):**
```powershell
cd your-new-project
.\setup.ps1
```

3. **Choose your git workflow** when prompted:
   - **Option 1**: Remove git history and start fresh (creates new git repo)
   - **Option 2**: Remove git history, no git init (ready for `git clone`)
   - **Option 3**: Keep current git history (for exploring the boilerplate)
   - **Option 4**: Skip git setup (run script again later)

The setup script will:
- Install uv if not already present
- Create a virtual environment in `.venv/`
- Install all dependencies (including dev dependencies)
- Clean up any existing cache files
- Handle git repository initialization based on your choice

### Typical Workflows

**For a brand new project:**
```bash
# Clone the boilerplate
git clone <this-boilerplate-repo> my-new-project
cd my-new-project

# Run setup and choose option 1 (remove history + git init)
./setup.sh  # or .\setup.ps1 on Windows

# Start coding!
```

**To connect to an existing repository:**
```bash
# Clone the boilerplate
git clone <this-boilerplate-repo> my-existing-project
cd my-existing-project

# Run setup and choose option 2 (remove history, no git init)
./setup.sh  # or .\setup.ps1 on Windows

# Clone your existing project (this will merge the boilerplate files)
git clone <your-existing-repo-url> .

# If your existing project has a requirements.txt, migrate to uv:
uv add --requirements requirements.txt  # Adds all packages to pyproject.toml
rm requirements.txt  # Optional: remove the old file

# Sync the environment with all dependencies
uv sync

# Your virtual environment is now ready! Start coding.
```

## 📁 Project Structure

```
your-project/
├── src/
│   └── MyModule/           # Your main module code goes here
│       └── __init__.py     # Module initialization
├── tests/
│   ├── __init__.py
│   └── test_mymodule.py    # Your tests go here
├── .gitignore              # Git ignore patterns for Python projects
├── pyproject.toml          # Project configuration and dependencies
├── setup.sh               # Linux/macOS setup script
├── setup.ps1              # Windows PowerShell setup script
└── HOW2USEIT.md           # This file
```

## 🔄 Migrating from requirements.txt

If you have an existing Python project with a `requirements.txt` file, here's how to migrate it to use uv and this boilerplate:

```bash
# After setting up the boilerplate (option 2) and cloning your existing project

# Migrate your requirements.txt to pyproject.toml
uv add --requirements requirements.txt

# For development dependencies (if you have requirements-dev.txt or similar):
uv add --dev --requirements requirements-dev.txt

# Remove old requirement files (optional)
rm requirements.txt requirements-dev.txt

# Sync to ensure everything is installed
uv sync

# Your project is now fully migrated to uv!
```

**Benefits of migrating to uv:**
- Faster dependency resolution and installation
- Built-in virtual environment management
- Modern pyproject.toml-based configuration
- Automatic dependency locking with uv.lock
- Better dependency conflict resolution

## 🔧 Development Workflow

### 1. Daily Development - Getting Started

**After the initial setup, when you come back to code:**

```bash
# Navigate to your project
cd my-project

# Option A: Use uv to run commands (recommended - no activation needed)
uv run pytest                    # Run tests
uv run python src/mymodule.py   # Run your code
uv add requests                  # Add new dependencies

# Option B: Activate the virtual environment manually
source .venv/bin/activate        # Linux/macOS
# or
.venv\Scripts\activate           # Windows

# Then use regular commands
pytest
python src/mymodule.py
```

**Key points:**
- The `.venv` virtual environment is created during setup but not automatically activated
- Use `uv run <command>` to run commands in the virtual environment without activating
- Or manually activate the environment if you prefer traditional workflow

### 2. Environment Activation (Manual Method)

**Linux/macOS:**
```bash
source .venv/bin/activate
```

**Windows Command Prompt:**
```cmd
.venv\Scripts\activate.bat
```

**Windows PowerShell:**
```powershell
.venv\Scripts\Activate.ps1
```

### 2. Start Coding
- Put your main module code in `src/MyModule/`
- Write tests in the `tests/` directory
- Follow the existing naming conventions

### 3. Run Tests
```bash
# Run all tests
uv run pytest

# Run with coverage report
uv run pytest --cov=src

# Run specific test file
uv run pytest tests/test_mymodule.py
```

### 4. Add Dependencies

**Runtime dependencies:**
```bash
uv add package-name
```

**Development dependencies:**
```bash
uv add --dev package-name
```

### 5. Install Your Module in Development Mode
```bash
uv pip install -e .
```

## 📝 Customizing for Your Project

### 1. Update Project Metadata
Edit `pyproject.toml` and change:
- `name` - Your module name
- `version` - Your version
- `description` - Project description
- Add/remove dependencies as needed

### 2. Rename the Module
1. Rename `src/MyModule/` to `src/YourModuleName/`
2. Update imports in your tests
3. Update the coverage configuration in `pyproject.toml` if needed

### 3. Configure Testing
The project comes with pytest configured with:
- Code coverage reporting
- HTML coverage reports (in `htmlcov/`)
- Proper test discovery patterns

Modify the `[tool.pytest.ini_options]` section in `pyproject.toml` to customize test behavior.

## 🔄 Managing Dependencies

### View Installed Packages
```bash
uv pip list
```

### Update Dependencies
```bash
uv sync --upgrade
```

### Lock Dependencies
Dependencies are automatically locked in `uv.lock` when you run `uv sync`.

## 🧪 Testing Best Practices

1. **Write tests first** - Follow TDD principles
2. **Organize tests** - Mirror your `src/` structure in `tests/`
3. **Use descriptive names** - Test functions should describe what they test
4. **Check coverage** - Aim for high test coverage
5. **Run tests frequently** - Use `uv run pytest` during development

## 📊 Coverage Reports

After running tests with coverage:
- Terminal report shows coverage percentages
- HTML report is generated in `htmlcov/index.html`
- Open `htmlcov/index.html` in your browser for detailed coverage visualization

## 🔄 Re-running Setup Scripts

The setup scripts are **idempotent** - you can run them multiple times safely. This is useful for:

- **Refreshing your environment** after pulling boilerplate updates
- **Handling git setup later** if you chose "Skip" initially
- **Fixing issues** with dependencies or virtual environment
- **Switching git workflows** (run again and choose a different option)

**Example scenarios:**
```bash
# Initial setup - chose to skip git setup
./setup.sh  # Choose option 4 (skip)

# Later, run again to handle git
./setup.sh  # Choose option 2 (prepare for git clone)
git clone <your-repo-url> .

# Or refresh after updating the boilerplate
./setup.sh  # Choose option 3 (keep git history)
```

## 🐛 Troubleshooting

### uv Command Not Found
If `uv` is not in your PATH after installation:
- **Linux/macOS**: Add `~/.cargo/bin` to your PATH
- **Windows**: The installer should handle PATH automatically, but restart your terminal

### Virtual Environment Issues
If you have issues with the virtual environment:
```bash
# Remove and recreate (the setup script will handle this automatically)
./setup.sh    # Linux/macOS
.\setup.ps1   # Windows

# Or manually:
rm -rf .venv        # Linux/macOS
rmdir /s .venv      # Windows cmd
uv sync
```

### Permission Issues (Windows PowerShell)
If you get execution policy errors:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Git Conflicts After Option 2
If you chose option 2 and have conflicts when cloning:
```bash
# Back up your boilerplate files first
mkdir ../boilerplate-backup
cp -r . ../boilerplate-backup/

# Then clone with force
git clone <your-repo-url> . --force

# Manually merge the files you need from ../boilerplate-backup/
```

## 📚 Additional Resources

- [uv Documentation](https://docs.astral.sh/uv/)
- [pytest Documentation](https://docs.pytest.org/)
- [Python Packaging Guide](https://packaging.python.org/)
- [PEP 621 - Project Metadata](https://peps.python.org/pep-0621/)

## 💡 Tips

1. **Use uv for everything** - It's faster than pip and handles dependencies better
2. **Keep pyproject.toml updated** - It's your single source of truth for project configuration
3. **Commit uv.lock** - It ensures reproducible installs across environments
4. **Use dev dependencies** - Keep testing and development tools separate from runtime dependencies
5. **Regular testing** - Set up CI/CD to run tests automatically

Happy coding! 🎉