#!/bin/bash

# re4c Command Copying Script
# Copies all commands from source location and adds version metadata

set -e

SOURCE_DIR="/Users/hyuan/.claude/commands"
DEST_BASE="~/Development/_organized/active/re4c/commands"
RE4C_VERSION="1.0.0"
INITIAL_VERSION="1.0.0"
TODAY=$(date "+%Y-%m-%d")

# Expand tilde in destination
DEST_BASE="${DEST_BASE/#\~/$HOME}"

# Function to determine category for a file
get_category() {
    local filename="$1"
    
    case "$filename" in
        # Core Workflow
        "generate-tasks.md"|"generate-slices.md"|"process-slices.md"|"process-slices-multiagent.md"|"create-prd.md"|"create-drd.md"|"create-trd.md"|"ai-dev-help.md")
            echo "core"
            ;;
        # Validation
        "validate-slice-completion.md"|"tdd-test-first.md"|"cleanup-workspace-agent.md"|"slice-retrospective.md"|"architecture-review.md"|"security-scan.md")
            echo "validation"
            ;;
        # Development
        "next-app.md"|"next-api.md"|"react-component.md"|"django-api.md"|"fastapi-setup.md"|"neon-setup.md"|"db-migrate.md"|"lint-setup.md"|"test-harness.md"|"pre-commit-hooks.md"|"universal-claude.md"|"setup-claude-standards.md"|"context-prime.md"|"prime.md"|"create-pr.md"|"fix-github-issue.md"|"smart-commit.md"|"multiagent-worktree.md")
            echo "development"
            ;;
        # Deployment
        "vercel-deploy.md"|"railway-deploy.md"|"docker-optimize.md"|"monitoring-setup.md"|"vercel-scan.md")
            echo "deployment"
            ;;
        # Documentation
        "docs-cleanup.md"|"docs-organize.md"|"docs-update.md"|"meta-docs-standards.md"|"prepare-open-source.md")
            echo "documentation"
            ;;
        *)
            echo "development"  # Default category
            ;;
    esac
}

echo "🚀 Starting re4c command copying process..."
echo "Source: $SOURCE_DIR"
echo "Destination: $DEST_BASE"
echo ""

# Function to add version metadata to file
add_version_metadata() {
    local file="$1"
    local category="$2"
    
    # Create a temporary file with updated frontmatter
    local temp_file=$(mktemp)
    local in_frontmatter=false
    local frontmatter_ended=false
    local added_metadata=false
    
    while IFS= read -r line; do
        if [[ "$line" == "---" ]]; then
            echo "$line" >> "$temp_file"
            if [[ "$in_frontmatter" == "false" ]]; then
                in_frontmatter=true
            else
                # End of frontmatter, add our metadata if not already added
                if [[ "$added_metadata" == "false" ]]; then
                    echo "version: \"$INITIAL_VERSION\"" >> "$temp_file"
                    echo "re4c_version: \"$RE4C_VERSION\"" >> "$temp_file"
                    echo "category: \"$category\"" >> "$temp_file"
                    echo "last_updated: \"$TODAY\"" >> "$temp_file"
                    added_metadata=true
                fi
                frontmatter_ended=true
            fi
        elif [[ "$in_frontmatter" == "true" ]] && [[ "$frontmatter_ended" == "false" ]]; then
            # We're in frontmatter, check if we need to update existing metadata
            if [[ "$line" =~ ^version: ]] || [[ "$line" =~ ^re4c_version: ]] || [[ "$line" =~ ^category: ]] || [[ "$line" =~ ^last_updated: ]]; then
                # Skip existing metadata, we'll add our own
                continue
            else
                echo "$line" >> "$temp_file"
            fi
        else
            # After frontmatter or not in frontmatter
            echo "$line" >> "$temp_file"
        fi
    done < "$file"
    
    # If no frontmatter was found, add it
    if [[ "$in_frontmatter" == "false" ]]; then
        local content_file=$(mktemp)
        cp "$file" "$content_file"
        
        cat > "$temp_file" << EOF
---
description: "$(basename "$file" .md | tr '-' ' ' | sed 's/\b\w/\U&/g') command"
version: "$INITIAL_VERSION"
re4c_version: "$RE4C_VERSION"
category: "$category"
last_updated: "$TODAY"
---

EOF
        cat "$content_file" >> "$temp_file"
        rm "$content_file"
    fi
    
    # Replace original file with updated version
    mv "$temp_file" "$file"
}

# Copy commands with categorization
copied_count=0
for file in "$SOURCE_DIR"/*.md; do
    if [[ -f "$file" ]]; then
        filename=$(basename "$file")
        
        # Skip README and other non-command files
        if [[ "$filename" == "README.md" ]]; then
            continue
        fi
        
        # Determine category
        category=$(get_category "$filename")
        
        # Create destination directory
        dest_dir="$DEST_BASE/$category"
        mkdir -p "$dest_dir"
        
        # Copy file
        dest_file="$dest_dir/$filename"
        cp "$file" "$dest_file"
        
        # Add version metadata
        add_version_metadata "$dest_file" "$category"
        
        echo "✅ Copied $filename to $category/"
        ((copied_count++))
    fi
done

echo ""
echo "🎯 Command copying complete!"
echo "📊 Statistics:"
echo "   - Total commands copied: $copied_count"
echo "   - Categories used:"
for category in core validation development deployment documentation; do
    count=$(find "$DEST_BASE/$category" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
    if [[ "$count" -gt 0 ]]; then
        echo "     - $category: $count files"
    fi
done
echo ""
echo "📁 Commands organized in: $DEST_BASE"