---
description: Sort and audit existing docs directory into standardized structure with staleness detection
argument-hint: [docs directory path or leave empty for ./docs]
---
version: "1.0.0"
re4c_version: "1.0.0"
category: "documentation"
last_updated: "2025-09-08"

Organize and audit documentation directory: $ARGUMENTS

Documentation organization workflow:
1. **Directory Analysis**: Scan existing docs structure
   - Inventory all documentation files and formats
   - Identify current organization patterns
   - Map content types to standardized categories
   - Generate initial file classification report
   - Detect duplicate or similar content

2. **Content Classification**: Categorize documents by purpose
   - Architecture: ADRs, system design, technical decisions
   - API: Endpoint docs, schemas, integration guides
   - User Guides: Tutorials, workflows, end-user help
   - Development: Setup, contributing, coding standards
   - Operations: Deployment, monitoring, troubleshooting

3. **Structure Migration**: Move files to standardized directories
   - Create standard directory structure if missing
   - Move files to appropriate categories based on content analysis
   - Preserve git history during file moves
   - Update internal links and references
   - Generate directory README files with category descriptions

4. **Staleness Detection**: Identify outdated and irrelevant documents
   - Check file modification dates against recent code changes
   - Scan for references to deleted/moved code files
   - Identify documents referencing deprecated APIs or features
   - Flag documents with broken internal/external links
   - Detect documents with outdated dependency versions

5. **Audit Report Generation**: Create comprehensive status report
   - Categorized file listings with move recommendations
   - Staleness analysis with confidence scores
   - Duplicate content identification
   - Missing documentation recommendations
   - Link validation results

Implementation process:

```bash
#!/bin/bash

DOCS_DIR="${1:-./docs}"
AUDIT_DIR="$DOCS_DIR/.audit"

echo "📋 Starting documentation organization for $DOCS_DIR"

# Create audit directories
mkdir -p "$AUDIT_DIR"/{needs-update,for-deletion,organized}

# 1. Content Analysis
echo "🔍 Analyzing existing documentation..."

# Scan for different doc types
find "$DOCS_DIR" -type f \( -name "*.md" -o -name "*.rst" -o -name "*.txt" \) \
  -not -path "*/.audit/*" > "$AUDIT_DIR/all-docs.txt"

# Classify by content patterns
grep -l "API\|endpoint\|schema\|swagger" $(cat "$AUDIT_DIR/all-docs.txt") > "$AUDIT_DIR/api-docs.txt" || touch "$AUDIT_DIR/api-docs.txt"
grep -l "architecture\|design\|ADR\|decision" $(cat "$AUDIT_DIR/all-docs.txt") > "$AUDIT_DIR/arch-docs.txt" || touch "$AUDIT_DIR/arch-docs.txt"
grep -l "setup\|install\|development\|contributing" $(cat "$AUDIT_DIR/all-docs.txt") > "$AUDIT_DIR/dev-docs.txt" || touch "$AUDIT_DIR/dev-docs.txt"
grep -l "deploy\|monitoring\|ops\|production" $(cat "$AUDIT_DIR/all-docs.txt") > "$AUDIT_DIR/ops-docs.txt" || touch "$AUDIT_DIR/ops-docs.txt"

# 2. Staleness Detection
echo "⏰ Detecting stale documentation..."

# Find files not modified in last 6 months
find "$DOCS_DIR" -name "*.md" -not -path "*/.audit/*" -mtime +180 > "$AUDIT_DIR/old-files.txt"

# Check for references to non-existent files
for doc in $(cat "$AUDIT_DIR/all-docs.txt"); do
  # Extract relative file references
  grep -o '\]\([^)]*\)' "$doc" | sed 's/](\(.*\)/\1/' | while read ref; do
    if [[ "$ref" =~ ^[^http] && ! -f "$(dirname "$doc")/$ref" ]]; then
      echo "$doc: broken reference to $ref" >> "$AUDIT_DIR/broken-refs.txt"
    fi
  done
done
```

Staleness detection algorithms:
1. **File Age Analysis**: Documents unmodified for 6+ months
2. **Code Reference Scanning**: Documents referencing deleted/moved code
3. **Dependency Version Checking**: Documents with outdated package versions
4. **Link Validation**: Broken internal and external links
5. **API Endpoint Validation**: References to deprecated or changed endpoints

Organization output structure:
```
docs/
├── architecture/
│   ├── README.md
│   ├── system-overview.md
│   └── decisions/
├── api/
│   ├── README.md
│   ├── authentication.md
│   └── endpoints/
├── user-guides/
│   ├── README.md
│   ├── getting-started.md
│   └── tutorials/
├── development/
│   ├── README.md
│   ├── setup.md
│   └── contributing.md
├── operations/
│   ├── README.md
│   ├── deployment.md
│   └── monitoring.md
└── .audit/
    ├── needs-update/     # Files flagged for updates
    ├── for-deletion/     # Files recommended for deletion
    ├── organized/        # Successfully categorized files
    └── audit-report.md   # Comprehensive analysis report
```

Audit report template:
```markdown
# Documentation Audit Report

Generated: $(date)
Total Files: $(wc -l < all-docs.txt)

## Organization Summary
- Architecture: $(wc -l < arch-docs.txt) files
- API Documentation: $(wc -l < api-docs.txt) files  
- User Guides: $(wc -l < user-docs.txt) files
- Development: $(wc -l < dev-docs.txt) files
- Operations: $(wc -l < ops-docs.txt) files
- Uncategorized: $(wc -l < uncategorized.txt) files

## Staleness Analysis
- Files older than 6 months: $(wc -l < old-files.txt)
- Broken references detected: $(wc -l < broken-refs.txt)
- Duplicate content identified: $(wc -l < duplicates.txt)

## Recommended Actions
1. Move $(wc -l < for-deletion/list.txt) files to deletion queue
2. Update $(wc -l < needs-update/list.txt) files flagged as stale
3. Consolidate $(wc -l < duplicates.txt) duplicate documents
4. Create missing category documentation
```

Quality checks:
- Verify all files have been categorized or flagged
- Ensure no content is lost during organization
- Validate that moved files maintain git history
- Confirm internal links are updated correctly
