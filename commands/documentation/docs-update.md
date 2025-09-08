---
description: Systematically update documentation flagged as needing updates during organization audit
argument-hint: [audit directory path or leave empty for ./docs/.audit]
---
version: "1.0.0"
re4c_version: "1.0.0"
category: "documentation"
last_updated: "2025-09-08"

Update flagged documentation from audit results: $ARGUMENTS

Documentation update workflow:
1. **Update Queue Processing**: Review and prioritize flagged documents
   - Process files from `.audit/needs-update/` directory
   - Categorize updates by type: content, links, metadata, structure
   - Prioritize by document importance and staleness severity
   - Identify dependencies between documents for update ordering
   - Generate update plan with effort estimates

2. **Content Analysis**: Understand current state and required changes
   - Parse existing document structure and metadata
   - Identify outdated code examples and references
   - Check for broken internal and external links
   - Validate technical accuracy against current codebase
   - Assess compliance with new documentation standards

3. **Automated Updates**: Apply mechanical changes where possible
   - Update document metadata and frontmatter
   - Fix broken internal links after file reorganization
   - Update dependency versions and package references
   - Refresh code snippets from current source files
   - Apply consistent formatting and style

4. **Manual Review Queue**: Flag content requiring human judgment
   - Complex architectural changes needing expert review
   - User workflow changes affecting multiple documents
   - Breaking changes requiring migration guides
   - Conceptual content that may need complete rewrite
   - Screenshots or diagrams needing visual updates

5. **Quality Validation**: Ensure updates maintain document quality
   - Verify all links are working and current
   - Ensure code examples are tested and functional
   - Validate that content serves its intended audience
   - Check compliance with documentation standards
   - Confirm proper cross-referencing with related documents

Implementation process:

```bash
#!/bin/bash

AUDIT_DIR="${1:-./docs/.audit}"
DOCS_DIR="$(dirname "$AUDIT_DIR")"
UPDATE_REPORT="$AUDIT_DIR/update-report.md"

echo "📝 Starting systematic documentation updates from $AUDIT_DIR"

# Validate audit directory exists
if [[ ! -d "$AUDIT_DIR/needs-update" ]]; then
  echo "❌ No update queue found. Run docs-organize first."
  exit 1
fi

# Create update tracking directories
mkdir -p "$AUDIT_DIR/updates"/{automated,manual-review,completed}

echo "🔍 Analyzing update queue..."

# 1. Categorize updates by type
UPDATE_LIST="$AUDIT_DIR/needs-update/list.txt"
if [[ -f "$UPDATE_LIST" ]]; then
  while read -r file; do
    # Check what type of updates are needed
    
    # Metadata updates (missing frontmatter)
    if ! grep -q "^---" "$file"; then
      echo "$file" >> "$AUDIT_DIR/updates/metadata-fixes.txt"
    fi
    
    # Broken link updates
    if grep -q "](.*\.md)" "$file"; then
      echo "$file" >> "$AUDIT_DIR/updates/link-fixes.txt"
    fi
    
    # Old code references
    if grep -q "\`\`\`\|npm install\|pip install" "$file"; then
      echo "$file" >> "$AUDIT_DIR/updates/code-updates.txt"
    fi
    
    # Structure updates (no proper headings)
    if ! grep -q "^# " "$file"; then
      echo "$file" >> "$AUDIT_DIR/updates/structure-fixes.txt"
    fi
    
  done < "$UPDATE_LIST"
fi
```

Automated update types:
1. **Metadata Standardization**: Add missing frontmatter
   ```yaml
   ---
   title: "$(basename "$file" .md | tr '-' ' ' | sed 's/\b\w/\U&/g')"
   description: "Auto-generated description - needs manual review"
   last_updated: "$(date +%Y-%m-%d)"
   status: "current"
   audience: "developer"  # Auto-detect from content patterns
   ---
   ```

2. **Link Repair**: Fix broken internal references
   ```bash
   # Update moved file references
   sed -i 's|\](\.\.\/old-location\/|\](../new-location/|g' "$file"
   
   # Fix broken relative links
   find "$DOCS_DIR" -name "*.md" -exec grep -l "$(basename "$file")" {} \; | \
     xargs sed -i "s|old-path/$(basename "$file")|new-path/$(basename "$file")|g"
   ```

3. **Code Snippet Refresh**: Update outdated examples
   ```bash
   # Update package versions
   sed -i 's/npm install package@1\./npm install package@2./g' "$file"
   
   # Update API endpoints
   sed -i 's|/api/v1/|/api/v2/|g' "$file"
   
   # Update configuration examples
   # (Pull from actual config files in repo)
   ```

Manual review categorization:
```markdown
## Update Categories

### High Priority (Complete within 1 week)
- User-facing tutorials with broken workflows
- API documentation with incorrect endpoints  
- Setup guides with outdated installation steps
- Security-related documentation with vulnerabilities

### Medium Priority (Complete within 1 month)
- Architecture documentation needing conceptual updates
- Integration guides with deprecated services
- Troubleshooting guides for resolved issues
- Performance optimization guides with outdated metrics

### Low Priority (Complete within quarter)
- Historical context documentation
- Advanced configuration guides
- Supplementary reference materials
- Nice-to-have tutorial enhancements
```

Update execution workflow:
```bash
# Process automated updates first
echo "🤖 Applying automated updates..."

# 1. Add missing metadata
if [[ -f "$AUDIT_DIR/updates/metadata-fixes.txt" ]]; then
  while read -r file; do
    # Determine document type and audience from content
    AUDIENCE="developer"
    if grep -qi "user guide\|tutorial\|how to" "$file"; then
      AUDIENCE="user"
    elif grep -qi "deployment\|monitoring\|ops" "$file"; then
      AUDIENCE="ops"
    fi
    
    TITLE="$(basename "$file" .md | tr '-' ' ' | sed 's/\b\w/\U&/g')"
    
    # Add frontmatter to beginning of file
    {
      echo "---"
      echo "title: \"$TITLE\""
      echo "description: \"Auto-generated description - needs manual review\""
      echo "last_updated: \"$(date +%Y-%m-%d)\""
      echo "status: \"current\""
      echo "audience: \"$AUDIENCE\""
      echo "---"
      echo ""
      cat "$file"
    } > "$file.tmp" && mv "$file.tmp" "$file"
    
    echo "✅ Added metadata to $file"
  done < "$AUDIT_DIR/updates/metadata-fixes.txt"
fi

# 2. Fix broken links
if [[ -f "$AUDIT_DIR/updates/link-fixes.txt" ]]; then
  while read -r file; do
    # Update common broken link patterns
    sed -i 's|\](\.\.\/docs\/|\](../|g' "$file"
    sed -i 's|\](docs\/|\](|g' "$file"
    
    echo "🔗 Fixed links in $file"
  done < "$AUDIT_DIR/updates/link-fixes.txt"
fi

# 3. Generate manual review tasks
echo "👥 Generating manual review queue..."
cat > "$AUDIT_DIR/updates/manual-tasks.md" << EOF
# Manual Review Tasks

## Code Example Updates
$(cat "$AUDIT_DIR/updates/code-updates.txt" 2>/dev/null | sed 's/^/- [ ] /')

## Content Review Required  
$(cat "$AUDIT_DIR/updates/content-review.txt" 2>/dev/null | sed 's/^/- [ ] /')

## Structure Improvements
$(cat "$AUDIT_DIR/updates/structure-fixes.txt" 2>/dev/null | sed 's/^/- [ ] /')

## Instructions
1. Review each file for technical accuracy
2. Update code examples to match current API
3. Verify all links work correctly
4. Ensure content serves intended audience
5. Update last_updated date after changes
EOF
```

Quality validation checks:
1. **Link Validation**: Verify all internal and external links
   ```bash
   # Check internal links
   find "$DOCS_DIR" -name "*.md" -exec grep -H "]\([^)]*\.md" {} \; | \
     while IFS: read file link; do
       target="$(echo "$link" | sed 's/.*](\([^)]*\).*/\1/')"
       if [[ ! -f "$(dirname "$file")/$target" ]]; then
         echo "❌ Broken link in $file: $target"
       fi
     done
   ```

2. **Code Example Testing**: Validate code snippets work
   ```bash
   # Extract and test code examples
   find "$DOCS_DIR" -name "*.md" -exec awk '/```bash/,/```/' {} \; | \
     grep -v '```' > /tmp/doc-commands.sh
   # Run basic syntax check
   bash -n /tmp/doc-commands.sh
   ```

3. **Metadata Compliance**: Ensure all documents have proper frontmatter
   ```bash
   # Check for missing metadata
   find "$DOCS_DIR" -name "*.md" -exec grep -L "^---" {} \; > \
     "$AUDIT_DIR/updates/missing-metadata.txt"
   ```

Update completion report:
```markdown
# Documentation Update Report

**Date:** $(date)
**Audit Source:** $AUDIT_DIR

## Automated Updates Completed
- Metadata added: $(wc -l < "$AUDIT_DIR/updates/metadata-fixes.txt" 2>/dev/null || echo 0)
- Links fixed: $(wc -l < "$AUDIT_DIR/updates/link-fixes.txt" 2>/dev/null || echo 0)
- Structure standardized: $(wc -l < "$AUDIT_DIR/updates/structure-fixes.txt" 2>/dev/null || echo 0)

## Manual Review Queue
- Code examples needing update: $(wc -l < "$AUDIT_DIR/updates/code-updates.txt" 2>/dev/null || echo 0)
- Content requiring review: $(wc -l < "$AUDIT_DIR/updates/content-review.txt" 2>/dev/null || echo 0)

## Next Steps
1. Review and complete manual tasks in updates/manual-tasks.md
2. Run link validation to verify fixes
3. Test code examples for accuracy
4. Update documentation site/index as needed
5. Schedule next quarterly documentation audit
```

Integration with development workflow:
- Create GitHub issues for manual review tasks
- Set up automated link checking in CI/CD
- Schedule regular documentation health checks
- Track documentation debt in project metrics
