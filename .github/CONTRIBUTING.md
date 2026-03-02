# Contributing to ADO Visualization

## Development Setup

### Prerequisites

- Python 3.9+
- Git
- Azure DevOps PAT

### Setup

```bash
git clone <repo-url>
cd "ADO Visualization"
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt -r requirements-dev.txt
pip install pre-commit && pre-commit install
export AZURE_DEVOPS_PAT="your_token"
```

## Code Style

- **PEP 8** compliant
- **100 character** line length
- **Type hints** required
- **Docstrings** required

### Tools

```bash
black --line-length 100 scripts/
flake8 scripts/ --max-line-length=100
isort --profile=black scripts/
```

### Pre-commit Hooks

- black, flake8, isort, pytest-quick
- Run manually: `pre-commit run --all-files`

## Testing

```bash
pytest                                    # All tests
pytest --cov=scripts --cov-report=html   # With coverage
pytest tests/test_validator.py           # Specific file
```

### Writing Tests

1. Place in `tests/` directory
2. Prefix with `test_`
3. Use fixtures from `conftest.py`
4. Mark slow tests: `@pytest.mark.slow`

## Pull Request Process

1. Create feature branch from `main`
2. Implement with tests
3. Run `pytest && pre-commit run --all-files`
4. Push to fork
5. Create PR

### PR Checklist

- [ ] Tests added/updated
- [ ] All tests passing
- [ ] Code formatted (black, isort)
- [ ] Linting passes (flake8)
- [ ] Type hints added
- [ ] Docstrings updated

## Commit Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types

- **feat**: New feature
- **fix**: Bug fix
- **docs**: Documentation
- **test**: Tests
- **refactor**: Refactoring
- **perf**: Performance

### Examples

```bash
git commit -m "feat(dashboard): add performance dashboard generator"

git commit -m "fix(cache): handle gzip compression

- Added 100KB threshold
- Improved error handling
- Updated tests

Fixes #123"
```

## Resources

- [Architecture](../Architecture/Storage_and_Patching.md)
- [README](../README.md)

---

Thank you for contributing! 🚀
