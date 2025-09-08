---
description: Configure comprehensive linting and formatting for multi-language projects
argument-hint: [languages and tech stack]
---
version: "1.0.0"
re4c_version: "1.0.0"
category: "development"
last_updated: "2025-09-08"

Configure linting and formatting for: $ARGUMENTS

Linting configuration:
- ESLint with TypeScript support for JavaScript/TypeScript
- Prettier for consistent code formatting
- Black and Ruff for Python code formatting
- Pre-commit hooks for automatic formatting
- IDE integration for format-on-save
- CI/CD integration with quality gates
- Custom rules for project-specific patterns
- Import sorting and organization
- Unused import detection and removal
- Code complexity analysis
- Security linting with specialized rules

Implementation includes:
1. ESLint configuration with recommended rules:

```json
{
  "extends": [
    "@next/next/recommended",
    "@typescript-eslint/recommended",
    "prettier"
  ],
  "rules": {
    "@typescript-eslint/no-unused-vars": "error",
    "@typescript-eslint/explicit-function-return-type": "warn",
    "prefer-const": "error",
    "no-var": "error"
  }
}
```

2. Prettier configuration:

```json
{
  "semi": true,
  "trailingComma": "es5",
  "singleQuote": true,
  "printWidth": 80,
  "tabWidth": 2,
  "useTabs": false
}
```

3. Python linting with pyproject.toml:

```toml
[tool.ruff]
select = ["E", "F", "UP", "B", "SIM", "I"]
ignore = ["E501"]
fixable = ["ALL"]

[tool.black]
line-length = 88
target-version = ['py311']
```

4. Pre-commit hooks configuration
5. VSCode/IDE settings for automatic formatting
6. GitHub Actions workflow for linting
7. Package.json scripts for manual linting
8. Makefile commands for project automation
9. Docker configuration for consistent environments
10. Documentation for team onboarding

Quality gates:
- Block commits with linting errors
- Require code formatting before merge
- Automated code review comments
- Integration with pull request checks
