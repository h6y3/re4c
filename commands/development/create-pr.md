---
description: Streamline pull request creation with formatting, quality checks, and template compliance
argument-hint: [feature description or branch context]
---
version: "1.0.0"
re4c_version: "1.0.0"
category: "development"
last_updated: "2025-09-08"

Create pull request for: $ARGUMENTS

PR creation workflow:
1. **Branch Preparation**: Ensure clean working state
   - Verify current branch is not main/master
   - Check for uncommitted changes and stage appropriately
   - Run linting and formatting on modified files
   - Execute relevant tests for changed code

2. **Code Quality Validation**: Pre-PR quality checks
   - Run ESLint/Prettier for JavaScript/TypeScript files
   - Run Black/Ruff for Python files
   - Execute unit tests for modified components
   - Check for security vulnerabilities in dependencies
   - Validate code coverage meets minimum thresholds

3. **Commit and Push**: Prepare branch for PR
   - Create descriptive commit with conventional format
   - Include detailed commit body with change summary
   - Push branch to origin with upstream tracking
   - Ensure branch is up-to-date with main/master

4. **PR Creation**: Generate comprehensive pull request
   - Use GitHub CLI to create PR with template
   - Generate PR title from commit messages or feature description
   - Include detailed description with:
     - Problem statement and motivation
     - Solution approach and key changes
     - Testing performed and validation steps
     - Breaking changes or migration notes
     - Screenshots or demos for UI changes
   - Add appropriate labels (feature, bugfix, documentation, etc.)
   - Assign reviewers based on code ownership
   - Link related issues and dependencies

5. **Quality Integration**: Attach quality metrics
   - Include code coverage report if applicable
   - Add performance impact assessment
   - Include security scan results
   - Attach build and test status
   - Add deployment preview links (Vercel, Netlify)

PR template structure:
```markdown
## Description

Brief description of changes and motivation

## Type of Change

- Bug fix (non-breaking change which fixes an issue)
- New feature (non-breaking change which adds functionality)
- Breaking change (fix or feature that would cause existing functionality to not work as expected)
- Documentation update

## Testing

- Unit tests pass
- Integration tests pass
- Manual testing completed
- Edge cases considered

## Checklist

- Code follows project style guidelines
- Self-review completed
- Code is commented, particularly in hard-to-understand areas
- Documentation updated
- No new warnings introduced
```

GitHub CLI commands:
- `gh pr create --title "feat: $ARGUMENTS" --body-file .github/pull_request_template.md`
- `gh pr edit --add-label "ready-for-review"`
- `gh pr view --web` - Open PR in browser for final review

Automation features:
- Auto-detection of PR type from file changes
- Automatic reviewer assignment based on CODEOWNERS
- Integration with CI/CD for automated checks
- Deployment preview link generation
