---
description: Analyze and fix GitHub issues using structured approach with GitHub CLI
argument-hint: [issue number]
---
version: "1.0.0"
re4c_version: "1.0.0"
category: "development"
last_updated: "2025-09-08"

Analyze and fix GitHub issue: $ARGUMENTS

Issue resolution workflow:
1. **Issue Analysis**: Use GitHub CLI to fetch comprehensive issue details
   - Run `gh issue view $ARGUMENTS --json title,body,labels,assignees,milestone`
   - Understand the problem described and reproduction steps
   - Identify related issues and previous attempts
   - Determine issue priority and complexity

2. **Codebase Investigation**: Search for relevant code and patterns
   - Use grep/ripgrep to find related code sections
   - Identify files and functions that need modification
   - Review recent changes that might be related
   - Check for similar patterns or previous fixes

3. **Solution Implementation**: Implement targeted fix
   - Create feature branch with descriptive name: `fix/issue-$ARGUMENTS-description`
   - Implement minimal changes to address root cause
   - Follow existing code patterns and conventions
   - Add appropriate error handling and logging

4. **Testing and Validation**: Ensure fix works correctly
   - Write or update tests to cover the fixed scenario
   - Run existing test suite to prevent regressions
   - Test the specific reproduction steps from the issue
   - Validate edge cases and error conditions

5. **Documentation and Communication**: Document changes and progress
   - Update relevant documentation if needed
   - Create descriptive commit message referencing the issue
   - Add inline code comments explaining complex logic
   - Update CHANGELOG if applicable

6. **Pull Request Creation**: Submit fix for review
   - Push changes to feature branch
   - Create PR with template compliance:
     - Clear description of the problem and solution
     - Testing steps and validation performed
     - Screenshots or logs demonstrating the fix
     - Closes #$ARGUMENTS reference
   - Add appropriate labels and reviewers
   - Link to related issues or PRs

GitHub CLI commands used:
- `gh issue view $ARGUMENTS` - Get issue details
- `gh issue edit $ARGUMENTS --add-label "in-progress"` - Update issue status
- `gh pr create --title "Fix #$ARGUMENTS: [description]" --body-file PR_TEMPLATE.md`
- `gh issue close $ARGUMENTS` - Close issue after merge

Quality checks:
- Ensure fix addresses root cause, not just symptoms
- Verify no regressions in existing functionality
- Confirm fix handles edge cases appropriately
- Validate that tests cover the fixed scenario
