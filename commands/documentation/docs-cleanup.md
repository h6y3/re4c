---
description: Delete outdated and irrelevant documentation identified during organization audit
argument-hint: [audit directory path or leave empty for ./docs/.audit]
---
version: "1.0.0"
re4c_version: "1.0.0"
category: "documentation"
last_updated: "2025-09-08"

Clean up outdated documentation from audit results: $ARGUMENTS

Documentation cleanup workflow:
1. **Audit Review**: Validate deletion candidates from organization phase
   - Review files flagged for deletion in `.audit/for-deletion/`
   - Verify staleness detection accuracy with manual spot checks
   - Confirm files have no current references in codebase
   - Check for historical value that should be archived instead
   - Validate that content isn't duplicated elsewhere

2. **Safety Validation**: Prevent accidental deletion of important content
   - Scan for references to deletion candidates in recent commits
   - Check if files are linked from current documentation
   - Verify files aren't referenced in CI/CD or deployment scripts
   - Confirm no active GitHub issues or PRs reference the files
   - Ensure files aren't part of onboarding or critical processes

3. **Archive vs Delete Decision**: Preserve valuable historical content
   - Move documents with historical value to `docs/archive/`
   - Delete truly obsolete files (outdated tutorials, temp files)
   - Preserve architectural decisions even if superseded
   - Keep significant troubleshooting guides for reference
   - Archive outdated API documentation for version history

4. **Cleanup Execution**: Safely remove or archive identified files
   - Create archive directory with dated subdirectories
   - Move archival candidates with preserved git history
   - Delete confirmed obsolete files with git remove
   - Update any remaining references to deleted files
   - Generate cleanup summary report

5. **Post-Cleanup Validation**: Ensure no broken references created
   - Scan remaining documentation for broken internal links
   - Validate that navigation and index files are updated
   - Check that README files still reference valid content
   - Confirm CI/CD processes aren't broken by removals
   - Test documentation site build if applicable

Implementation process:

```bash
#!/bin/bash

AUDIT_DIR="${1:-./docs/.audit}"
DOCS_DIR="$(dirname "$AUDIT_DIR")"
ARCHIVE_DIR="$DOCS_DIR/archive/$(date +%Y-%m)"
CLEANUP_REPORT="$AUDIT_DIR/cleanup-report.md"

echo "🧹 Starting documentation cleanup from $AUDIT_DIR"

# Validate audit directory exists
if [[ ! -d "$AUDIT_DIR/for-deletion" ]]; then
  echo "❌ No audit results found. Run docs-organize first."
  exit 1
fi

# Create archive directory
mkdir -p "$ARCHIVE_DIR"

# 1. Safety checks
echo "🔍 Performing safety validation..."

# Check for recent references to deletion candidates
DELETION_LIST="$AUDIT_DIR/for-deletion/list.txt"
if [[ -f "$DELETION_LIST" ]]; then
  while read -r file; do
    # Check git log for recent activity
    if git log --since="30 days ago" --name-only | grep -q "$(basename "$file")"; then
      echo "⚠️  $file has recent git activity - review carefully"
      echo "$file" >> "$AUDIT_DIR/recent-activity-warning.txt"
    fi
    
    # Check for current references in codebase
    if grep -r "$(basename "$file" .md)" . --exclude-dir=.git --exclude-dir=node_modules --exclude-dir=.audit; then
      echo "⚠️  $file may still be referenced - review carefully"
      echo "$file" >> "$AUDIT_DIR/potential-references.txt"
    fi
  done < "$DELETION_LIST"
fi

# 2. Interactive confirmation for risky deletions
echo "📋 Reviewing deletion candidates..."

# Show files with warnings for manual review
if [[ -f "$AUDIT_DIR/recent-activity-warning.txt" ]] || [[ -f "$AUDIT_DIR/potential-references.txt" ]]; then
  echo "⚠️  Some files need manual review before deletion:"
  cat "$AUDIT_DIR/recent-activity-warning.txt" 2>/dev/null
  cat "$AUDIT_DIR/potential-references.txt" 2>/dev/null
  echo ""
  echo "Files with warnings have been moved to $AUDIT_DIR/manual-review/"
  mkdir -p "$AUDIT_DIR/manual-review"
  if [[ -f "$AUDIT_DIR/recent-activity-warning.txt" ]]; then
    while read -r file; do
      echo "$(basename "$file"): Recent git activity detected" >> "$AUDIT_DIR/manual-review/warnings.txt"
    done < "$AUDIT_DIR/recent-activity-warning.txt"
  fi
fi
```

Cleanup decision matrix:
```markdown
| File Type | Age | References | Action |
|-----------|-----|------------|--------|
| API docs | >6mo | None | Delete |
| API docs | >6mo | Historical | Archive |
| Tutorials | >1yr | None | Delete |
| Architecture | Any | None | Archive |
| Temp files | >1mo | None | Delete |
| Troubleshooting | >1yr | None | Archive |
```

Archive organization:
```
docs/archive/
├── 2025-01/          # Monthly archive folders
│   ├── old-api-v1/   # Versioned API documentation
│   ├── deprecated-tutorials/
│   └── archive-index.md
├── 2024-12/
└── README.md         # Archive navigation and policy
```

Safety mechanisms:
1. **Dry Run Mode**: Preview actions without execution
   - Show what would be deleted vs archived
   - Display file sizes and modification dates
   - Preview impact on documentation structure
   - Generate confirmation checklist

2. **Git Integration**: Preserve history and enable recovery
   - Use `git mv` for archive operations
   - Use `git rm` for confirmed deletions
   - Create commit with detailed cleanup summary
   - Tag commit for easy recovery if needed

3. **Backup Creation**: Final safety net before cleanup
   - Create compressed backup of deletion candidates
   - Store backup with timestamp in `.audit/backups/`
   - Include restoration instructions
   - Set automatic cleanup of old backups

Cleanup execution:
```bash
# Archive files with historical value
mkdir -p "$ARCHIVE_DIR"/{api,architecture,troubleshooting}

# Process archival candidates
if [[ -f "$AUDIT_DIR/for-archival/list.txt" ]]; then
  while read -r file; do
    # Determine archive subdirectory based on content
    if grep -q "API\|endpoint" "$file"; then
      DEST="$ARCHIVE_DIR/api/"
    elif grep -q "architecture\|design\|ADR" "$file"; then
      DEST="$ARCHIVE_DIR/architecture/"
    else
      DEST="$ARCHIVE_DIR/"
    fi
    
    echo "📦 Archiving $file to $DEST"
    git mv "$file" "$DEST$(basename "$file")"
  done < "$AUDIT_DIR/for-archival/list.txt"
fi

# Delete confirmed obsolete files
if [[ -f "$AUDIT_DIR/for-deletion/confirmed.txt" ]]; then
  while read -r file; do
    echo "🗑️  Deleting $file"
    git rm "$file"
  done < "$AUDIT_DIR/for-deletion/confirmed.txt"
fi

# Generate cleanup report
cat > "$CLEANUP_REPORT" << EOF
# Documentation Cleanup Report

**Date:** $(date)
**Audit Source:** $AUDIT_DIR

## Summary
- Files archived: $(wc -l < "$AUDIT_DIR/for-archival/list.txt" 2>/dev/null || echo 0)
- Files deleted: $(wc -l < "$AUDIT_DIR/for-deletion/confirmed.txt" 2>/dev/null || echo 0)
- Files requiring manual review: $(wc -l < "$AUDIT_DIR/manual-review/warnings.txt" 2>/dev/null || echo 0)

## Archive Location
Archived files moved to: $ARCHIVE_DIR

## Manual Review Required
$(cat "$AUDIT_DIR/manual-review/warnings.txt" 2>/dev/null || echo "None")

## Recovery Instructions
To restore archived files:
\`\`\`bash
git log --oneline | grep "docs cleanup"  # Find cleanup commit
git show <commit-hash> --name-status     # See what was moved/deleted
git checkout <commit-hash>~1 -- path/to/file  # Restore specific file
\`\`\`
EOF
```

Post-cleanup validation:
- Run link checker on remaining documentation
- Verify documentation site builds successfully
- Update navigation and index files
- Confirm no CI/CD processes are broken
