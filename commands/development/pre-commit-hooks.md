---
description: Set up pre-commit hooks for automated code quality and security checks
argument-hint: [project tech stack and requirements]
---
version: "1.0.0"
re4c_version: "1.0.0"
category: "development"
last_updated: "2025-09-08"

Configure pre-commit hooks for: $ARGUMENTS

Pre-commit automation:
- Code formatting with language-specific tools
- Linting and static analysis execution
- Security vulnerability scanning
- Unit test execution for changed files
- Commit message validation
- Branch name validation
- File size and type restrictions
- Secrets detection and prevention
- Import sorting and organization
- Documentation generation and validation

Hook configuration includes:
1. `.pre-commit-config.yaml` setup:

```yaml
repos:
- repo: https://github.com/pre-commit/pre-commit-hooks
  rev: v4.4.0
  hooks:
  - id: trailing-whitespace
  - id: end-of-file-fixer
  - id: check-merge-conflict
  - id: check-yaml
  - id: check-json
  - id: detect-private-key

- repo: https://github.com/psf/black
  rev: 23.3.0
  hooks:
    - id: black
      language_version: python3.11

- repo: https://github.com/charliermarsh/ruff-pre-commit
  rev: v0.0.270
  hooks:
    - id: ruff
      args: [--fix, --exit-non-zero-on-fix]

- repo: https://github.com/pre-commit/mirrors-eslint
  rev: v8.42.0
  hooks:
    - id: eslint
      files: \.(js|jsx|ts|tsx)$
      args: [--fix]
```

2. Custom hooks for project-specific validation
3. Integration with existing CI/CD pipelines
4. Team installation and setup documentation
5. Bypass procedures for emergency commits
6. Performance optimization for large repositories
7. Custom commit message templates
8. Integration with issue tracking systems
9. Automated dependency updates
10. Code coverage validation

Security features:
- Secret scanning with GitLeaks
- Dependency vulnerability checking
- License compliance validation
- Security linting rules
- File permission validation
- Large file detection and prevention
