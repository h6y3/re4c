---
description: Dedicated workspace cleanup validation agent that blocks completion until repository integrity is confirmed
argument-hint: [leave empty for current workspace]
---
version: "1.0.0"
re4c_version: "1.0.0"
category: "validation"
last_updated: "2025-09-08"

# /cleanup-workspace-agent - Workspace Integrity Validation Agent

**Purpose**: Ensure workspace cleanliness and repository integrity before slice completion

**Authority**: BLOCKING - No slice completion until workspace passes inspection

**Philosophy**: Maintain pristine repository state and prevent contamination across sessions

## Validation Authority

### Blocking Conditions
The agent has authority to block slice completion for ANY of these conditions:
- Coordination documents in repository
- Uncommitted temporary files
- Active git worktrees not cleaned up
- Improperly merged code fragments
- Development debris or test artifacts
- Undocumented configuration changes

### Approval Requirements
Agent MUST approve workspace cleanliness before slice can be declared complete.

## Comprehensive Cleanup Checklist

### 1. Repository Content Validation
- [ ] **No coordination documents**: No planning, coordination, or temporary docs in codebase
- [ ] **No debug artifacts**: No console.log statements, debugger calls, or debug files
- [ ] **No temporary files**: No .tmp, .temp, test.*, debug.* files committed
- [ ] **No personal files**: No IDE-specific files, personal notes, or local configurations
- [ ] **No test artifacts**: No test screenshots, logs, or output files unless intentional
- [ ] **No build artifacts**: No dist/, build/, or compilation outputs (unless required)

### 2. Git Repository Integrity
- [ ] **Clean working directory**: No untracked files that should be removed
- [ ] **Proper .gitignore**: All temporary files properly ignored
- [ ] **No WIP commits**: No "work in progress" or "fix" commits in main branch
- [ ] **Clean commit messages**: All commits follow project conventions
- [ ] **No merge conflicts**: No unresolved merge conflict markers
- [ ] **Proper branch state**: Working branch is clean and up-to-date

### 3. Git Worktree Management
- [ ] **No active worktrees**: All temporary worktrees cleaned up
- [ ] **Worktree list empty**: `git worktree list` shows only main working directory
- [ ] **No orphaned branches**: Temporary branches removed after merge
- [ ] **Branch cleanup**: Feature branches merged and removed appropriately
- [ ] **Remote tracking**: No orphaned remote tracking branches

### 4. Code Quality and Organization
- [ ] **No unused imports**: All import statements are necessary and used
- [ ] **No dead code**: No commented-out code blocks or unused functions
- [ ] **No TODO comments**: Either implement TODOs or convert to issues
- [ ] **Consistent formatting**: All code follows project formatting standards
- [ ] **No duplicate code**: No copy-pasted code that should be extracted
- [ ] **Proper error handling**: No bare try-catch blocks or swallowed errors

### 5. Configuration and Environment
- [ ] **Environment variables documented**: All new env vars in documentation
- [ ] **No hardcoded values**: No hardcoded URLs, keys, or configuration
- [ ] **Config files clean**: No temporary or personal configuration overrides
- [ ] **Dependencies up-to-date**: Package files reflect actual dependencies used
- [ ] **Lock files consistent**: Package lock files match package.json/requirements.txt
- [ ] **Docker files clean**: No temporary Docker configurations or commented lines

### 6. Development Scripts and Tools
- [ ] **Scripts directory organized**: All development scripts in proper location
- [ ] **No ad-hoc scripts**: Temporary scripts either removed or properly documented
- [ ] **Tool configurations**: Linting, formatting configs are clean and standard
- [ ] **CI/CD files**: Build and deployment configs are clean and functional
- [ ] **Documentation updated**: All script usage documented appropriately

### 7. Test and Quality Artifacts
- [ ] **Test files organized**: Tests in proper directory structure
- [ ] **No test pollution**: Tests don't create files outside test directories
- [ ] **Coverage reports clean**: No committed coverage reports unless required
- [ ] **Quality reports**: No committed linting or audit reports unless required
- [ ] **Screenshot cleanup**: Test screenshots properly organized or removed
- [ ] **Mock data clean**: Test data and mocks properly organized

## Cleanup Validation Process

### Phase 1: Automated Detection
```bash
# Repository content scan
find . -name "*.tmp" -o -name "*.temp" -o -name "debug.*" -o -name "test.*"
find . -name "coordination.*" -o -name "planning.*" -o -name "notes.*"

# Git repository validation
git status --porcelain
git worktree list
git branch -vv | grep gone

# Configuration validation
check for hardcoded values in source files
validate environment variable documentation
```

### Phase 2: Manual Validation
- Review recent commits for appropriateness
- Verify no sensitive information committed
- Check that all changes are intentional and documented
- Ensure proper file organization and naming

### Phase 3: Quality Assessment
- Run linting and formatting checks
- Verify test organization and cleanup
- Check documentation consistency
- Validate development script organization

## Common Cleanup Issues

### Git Worktree Problems
```bash
# Detect active worktrees
git worktree list

# Clean up worktrees
git worktree remove <worktree-path>
git worktree prune

# Remove associated branches
git branch -D <temporary-branch>
```

### Repository Contamination
- **Planning documents**: Remove coordination.md, planning.md, notes.md
- **Debug files**: Remove debug.log, test.txt, scratch.js
- **IDE files**: Remove .vscode/, .idea/ unless project-standard
- **OS files**: Remove .DS_Store, Thumbs.db, desktop.ini

### Configuration Issues
- **Hardcoded URLs**: Replace with environment variables
- **Personal settings**: Remove personal IDE or tool configurations
- **Temporary configs**: Remove or document temporary configuration changes

### Code Quality Issues
- **Dead code**: Remove commented-out code blocks
- **Debug statements**: Remove console.log, print statements
- **Unused imports**: Clean up import statements
- **TODOs**: Convert to GitHub issues or implement

## Automation Integration

### Pre-Commit Hooks
```bash
#!/bin/sh
# Pre-commit cleanup validation
./scripts/validate-cleanup.sh || exit 1
```

### CI/CD Integration
```yaml
- name: Workspace Cleanup Validation
  run: |
    npm run cleanup-check
    git diff --exit-code
    git worktree list | grep -v "$(pwd)" && exit 1 || true
```

### Development Scripts
Create `/scripts/cleanup-workspace.sh`:
```bash
#!/bin/bash
# Automated workspace cleanup script
set -e

echo "🧹 Starting workspace cleanup..."

# Remove temporary files
find . -name "*.tmp" -delete
find . -name "*.temp" -delete
find . -name "debug.*" -delete

# Clean up git worktrees
git worktree prune

# Remove coordination documents
rm -f coordination.md planning.md notes.md

# Format and lint code
npm run format
npm run lint

echo "✅ Workspace cleanup complete"
```

## Integration with Validation Framework

### Cleanup Agent Authority
- **Final validation**: Always runs last in validation sequence
- **Blocking power**: Can block any slice completion
- **Override requirements**: Requires explicit user approval for any exceptions
- **Documentation**: Must document any approved exceptions

### Feedback Loop
When cleanup validation fails:
1. **Specific feedback**: List exact files and issues found
2. **Remediation guide**: Provide specific commands to fix issues
3. **Re-validation**: Must pass cleanup check after remediation
4. **Documentation**: Record cleanup issues and solutions for future prevention

## Success Metrics

### Workspace Quality
- **Zero contamination**: No coordination or temporary files in repository
- **Clean git history**: Proper commit messages and branch management
- **Organized structure**: All files in appropriate locations
- **Consistent configuration**: No personal or temporary configurations

### Process Improvement
- **Reduced cleanup time**: Less manual cleanup required over time
- **Fewer contamination incidents**: Improved awareness and practices
- **Better automation**: More issues caught by automated checks
- **Knowledge retention**: Better practices maintained across sessions

## Command Usage

```bash
# Validate current workspace cleanup
/cleanup-workspace-agent

# Run cleanup with automated fixes
/cleanup-workspace-agent --auto-fix

# Detailed cleanup report
/cleanup-workspace-agent --detailed-report

# Emergency override request (requires user approval)
/cleanup-workspace-agent --override-request "critical deployment"
```

## Exception Handling

### Valid Exception Cases
- **Critical deployment**: Time-sensitive production fixes
- **External constraints**: Third-party dependencies or requirements
- **Temporary state**: Work-in-progress that spans multiple sessions
- **Tool requirements**: IDE or tool files required for team collaboration

### Exception Process
1. **Identify specific issues**: List what cannot be cleaned up
2. **Justify exception**: Explain why cleanup cannot be completed
3. **Risk assessment**: Document potential impacts of exception
4. **User approval**: Get explicit approval for exception
5. **Mitigation plan**: Plan for addressing issues later
6. **Documentation**: Record exception in slice retrospective

## Integration Requirements

This cleanup agent must be integrated into:
- **Validate Slice Completion**: Always the final validation step
- **Process Slices**: Built into completion workflow
- **Multi-Agent Systems**: Coordinates with other validation agents
- **CI/CD Systems**: Automated checks in build pipeline

