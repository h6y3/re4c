---
description: Create structured commits with conventional commit format and context analysis
argument-hint: [commit scope or leave empty for auto-detection]
---
version: "1.0.0"
re4c_version: "1.0.0"
category: "development"
last_updated: "2025-09-08"

Generate smart commit for staged changes: $ARGUMENTS

Commit analysis process:
- Analyze staged file changes for commit type detection
- Run formatting (npm run format) to prevent pre-commit hook failures
- Re-stage any files modified by formatting
- Generate conventional commit format (type(scope): description)
- Include appropriate commit body with change summary
- Add breaking change notifications when applicable
- Reference related issues and pull requests
- Include co-author attribution for pair programming
- Validate commit message against team conventions
- Suggest commit scope based on file changes
- Add relevant tags and metadata

Conventional commit types:
- `feat`: New features or functionality
- `fix`: Bug fixes and corrections
- `docs`: Documentation updates
- `style`: Code style changes (formatting, missing semicolons)
- `refactor`: Code refactoring without behavior changes
- `perf`: Performance improvements
- `test`: Test additions or modifications
- `chore`: Maintenance tasks and tooling changes
- `ci`: CI/CD pipeline changes
- `build`: Build system and dependency changes

Implementation includes:
1. Staged changes analysis and categorization
2. Proactive formatting execution (npm run format)
3. Re-staging of formatting changes
4. Commit type detection based on file patterns
5. Conventional commit message generation
6. Commit body with detailed change description
7. Breaking change detection and notation
8. Issue reference extraction from branch names
9. Co-author detection from git configuration
10. Commit message validation against team standards
11. Suggested commit scope based on project structure
12. Integration with git hooks for validation

Commit message template:
```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

Example outputs:
- `feat(auth): add OAuth2 integration with Google provider`
- `fix(api): resolve race condition in user registration`
- `docs(readme): update installation instructions for Node 18`
