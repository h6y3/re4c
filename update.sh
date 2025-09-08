#!/bin/bash

# re4c Update Script
# Updates existing re4c installation to latest version

set -e

# Configuration
CLAUDE_DIR="$HOME/.claude"
COMMANDS_DIR="$CLAUDE_DIR/commands"
BACKUP_DIR="$CLAUDE_DIR/backups"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MANIFEST_FILE="$CLAUDE_DIR/.re4c-manifest.json"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Utility functions
log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Load version utilities
source "$SCRIPT_DIR/scripts/version-utils.sh"

print_header() {
    local current_version=$(get_installed_version)
    local new_version=$(get_repo_version)
    
    # Format version strings with proper padding for 42-char box width
    local current_line=$(printf "║  Current: v%-27s ║" "$current_version")
    local latest_line=$(printf "║  Latest:  v%-27s ║" "$new_version")
    
    echo "╔══════════════════════════════════════════╗"
    echo "║              re4c Update                 ║"
    echo "║     Rapid Engineering For Claude         ║"
    echo "║                                          ║"
    echo "$current_line"
    echo "$latest_line"
    echo "╚══════════════════════════════════════════╝"
    echo ""
}

get_installed_version() {
    if [[ -f "$MANIFEST_FILE" ]]; then
        jq -r '.re4c_version // "not-installed"' "$MANIFEST_FILE"
    else
        echo "not-installed"
    fi
}

get_repo_version() {
    # Extract version from this repository
    grep "^RE4C_VERSION=" "$SCRIPT_DIR/install.sh" | cut -d'"' -f2
}

check_installation() {
    log_info "Checking existing installation..."
    
    if [[ ! -f "$MANIFEST_FILE" ]]; then
        log_error "No re4c installation found"
        log_info "Run './install.sh' to install re4c first"
        exit 1
    fi
    
    if [[ ! -d "$COMMANDS_DIR" ]]; then
        log_error "Commands directory not found: $COMMANDS_DIR"
        log_error "Installation appears corrupted"
        exit 1
    fi
    
    log_success "Existing installation found"
}

check_for_updates() {
    local installed_version=$(get_installed_version)
    local repo_version=$(get_repo_version)
    
    log_info "Version check:"
    log_info "  Installed: $installed_version"
    log_info "  Available: $repo_version"
    
    if [[ $(compare_versions "$repo_version" "$installed_version") != "1" ]]; then
        log_success "You're already running the latest version!"
        log_info "No updates available."
        exit 0
    fi
    
    log_info "Updates available!"
    return 0
}

analyze_updates() {
    local updates=()
    local new_files=()
    local obsolete_files=()
    
    log_info "Analyzing available updates..."
    
    # Check all categories for updates
    for category in core validation development deployment documentation; do
        local source_dir="$SCRIPT_DIR/commands/$category"
        
        if [[ -d "$source_dir" ]]; then
            for source_file in "$source_dir"/*.md; do
                if [[ -f "$source_file" ]]; then
                    local filename=$(basename "$source_file")
                    local dest_file="$COMMANDS_DIR/$filename"
                    
                    if [[ -f "$dest_file" ]]; then
                        local existing_version=$(extract_version "$dest_file")
                        local new_version=$(extract_version "$source_file")
                        
                        if [[ $(compare_versions "$new_version" "$existing_version") == "1" ]]; then
                            updates+=("$filename|$existing_version|$new_version|$category")
                        fi
                    else
                        new_files+=("$filename|$category")
                    fi
                fi
            done
        fi
    done
    
    # Check for obsolete files (in manifest but not in repo)
    if command -v jq &> /dev/null; then
        while IFS= read -r filename; do
            local found=false
            for category in core validation development deployment documentation; do
                if [[ -f "$SCRIPT_DIR/commands/$category/$filename" ]]; then
                    found=true
                    break
                fi
            done
            if [[ "$found" == "false" ]]; then
                obsolete_files+=("$filename")
            fi
        done < <(jq -r '.installed_files | keys[]' "$MANIFEST_FILE" 2>/dev/null || true)
    fi
    
    # Display analysis results
    echo ""
    if [[ ${#updates[@]} -gt 0 ]]; then
        log_info "📦 Updates available (${#updates[@]} files):"
        for update in "${updates[@]}"; do
            IFS='|' read -r filename old_ver new_ver category <<< "$update"
            echo "   • $filename: $old_ver → $new_ver [$category]"
        done
        echo ""
    fi
    
    if [[ ${#new_files[@]} -gt 0 ]]; then
        log_info "🆕 New commands available (${#new_files[@]} files):"
        for new_file in "${new_files[@]}"; do
            IFS='|' read -r filename category <<< "$new_file"
            echo "   • $filename [$category]"
        done
        echo ""
    fi
    
    if [[ ${#obsolete_files[@]} -gt 0 ]]; then
        log_warning "⚠️  Obsolete commands (${#obsolete_files[@]} files):"
        for obsolete in "${obsolete_files[@]}"; do
            echo "   • $obsolete (no longer in repository)"
        done
        echo ""
    fi
    
    # Store analysis results for processing
    printf '%s\n' "${updates[@]}" > /tmp/re4c_updates
    printf '%s\n' "${new_files[@]}" > /tmp/re4c_new_files  
    printf '%s\n' "${obsolete_files[@]}" > /tmp/re4c_obsolete_files
}

apply_updates() {
    local auto_mode="$1"
    
    # Apply command updates
    if [[ -s /tmp/re4c_updates ]]; then
        log_info "Applying command updates..."
        
        while IFS='|' read -r filename old_ver new_ver category; do
            local source_file="$SCRIPT_DIR/commands/$category/$filename"
            local dest_file="$COMMANDS_DIR/$filename"
            
            if [[ "$auto_mode" == "auto" ]]; then
                local choice="y"
            else
                echo "Update $filename ($old_ver → $new_ver)?"
                read -p "Apply update? (y/n/d for diff): " choice
            fi
            
            case $choice in
                y|Y)
                    local backup_path=$(backup_file "$dest_file" "$BACKUP_DIR")
                    cp "$source_file" "$dest_file"
                    log_success "Updated $filename (backup: $(basename "$backup_path"))"
                    ;;
                n|N)
                    log_info "Skipped $filename"
                    ;;
                d|D)
                    echo "--- Differences (- current, + new) ---"
                    diff -u "$dest_file" "$source_file" || true
                    echo "--- End of differences ---"
                    # Ask again after showing diff
                    read -p "Apply update? (y/n): " choice
                    if [[ "$choice" =~ ^[Yy]$ ]]; then
                        local backup_path=$(backup_file "$dest_file" "$BACKUP_DIR")
                        cp "$source_file" "$dest_file"
                        log_success "Updated $filename (backup: $(basename "$backup_path"))"
                    else
                        log_info "Skipped $filename"
                    fi
                    ;;
            esac
        done < /tmp/re4c_updates
    fi
    
    # Install new commands
    if [[ -s /tmp/re4c_new_files ]]; then
        log_info "Installing new commands..."
        
        while IFS='|' read -r filename category; do
            local source_file="$SCRIPT_DIR/commands/$category/$filename"
            local dest_file="$COMMANDS_DIR/$filename"
            
            if [[ "$auto_mode" == "auto" ]]; then
                local choice="y"
            else
                read -p "Install new command $filename? (y/n): " choice
            fi
            
            if [[ "$choice" =~ ^[Yy]$ ]]; then
                cp "$source_file" "$dest_file"
                log_success "Installed new command: $filename"
            else
                log_info "Skipped $filename"
            fi
        done < /tmp/re4c_new_files
    fi
    
    # Handle obsolete files
    if [[ -s /tmp/re4c_obsolete_files ]]; then
        log_warning "Handling obsolete commands..."
        
        while IFS= read -r filename; do
            local obsolete_file="$COMMANDS_DIR/$filename"
            
            if [[ -f "$obsolete_file" ]]; then
                if [[ "$auto_mode" == "auto" ]]; then
                    local choice="n"  # Don't auto-remove obsolete files
                else
                    echo "Command $filename is no longer in the repository."
                    read -p "Remove obsolete command? (y/n): " choice
                fi
                
                if [[ "$choice" =~ ^[Yy]$ ]]; then
                    local backup_path=$(backup_file "$obsolete_file" "$BACKUP_DIR")
                    rm "$obsolete_file"
                    log_success "Removed obsolete command: $filename (backup: $(basename "$backup_path"))"
                else
                    log_info "Kept obsolete command: $filename"
                fi
            fi
        done < /tmp/re4c_obsolete_files
    fi
}

update_claude_md() {
    local auto_mode="$1"
    local existing_claude="$CLAUDE_DIR/CLAUDE.md"
    local new_claude="$SCRIPT_DIR/templates/CLAUDE.md"
    
    if [[ ! -f "$existing_claude" ]]; then
        log_info "Installing CLAUDE.md (was not present)"
        cp "$new_claude" "$existing_claude"
        log_success "CLAUDE.md installed"
        return 0
    fi
    
    local existing_version=$(extract_version "$existing_claude")
    local new_version=$(extract_version "$new_claude")
    
    if [[ $(compare_versions "$new_version" "$existing_version") == "1" ]]; then
        log_info "CLAUDE.md update available: $existing_version → $new_version"
        
        if [[ "$auto_mode" == "auto" ]]; then
            local choice="y"
        else
            read -p "Update CLAUDE.md? (y/n/d for diff): " choice
        fi
        
        case $choice in
            y|Y)
                local backup_path=$(backup_file "$existing_claude" "$BACKUP_DIR")
                cp "$new_claude" "$existing_claude"
                log_success "CLAUDE.md updated (backup: $(basename "$backup_path"))"
                ;;
            n|N)
                log_info "Kept existing CLAUDE.md"
                ;;
            d|D)
                echo "--- Differences (- current, + new) ---"
                diff -u "$existing_claude" "$new_claude" || true
                echo "--- End of differences ---"
                read -p "Apply update? (y/n): " choice
                if [[ "$choice" =~ ^[Yy]$ ]]; then
                    local backup_path=$(backup_file "$existing_claude" "$BACKUP_DIR")
                    cp "$new_claude" "$existing_claude"
                    log_success "CLAUDE.md updated (backup: $(basename "$backup_path"))"
                else
                    log_info "Kept existing CLAUDE.md"
                fi
                ;;
        esac
    else
        log_info "CLAUDE.md is up to date (version $existing_version)"
    fi
}

update_manifest() {
    log_info "Updating installation manifest..."
    
    local new_version=$(get_repo_version)
    local update_date=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
    
    # Update re4c version and last update check
    jq --arg version "$new_version" \
       --arg date "$update_date" \
       '.re4c_version = $version | .last_update_check = $date' \
       "$MANIFEST_FILE" > "$MANIFEST_FILE.tmp"
    mv "$MANIFEST_FILE.tmp" "$MANIFEST_FILE"
    
    # Update installed files information
    for cmd_file in "$COMMANDS_DIR"/*.md; do
        if [[ -f "$cmd_file" ]]; then
            local filename=$(basename "$cmd_file")
            local version=$(extract_version "$cmd_file")
            local category=$(extract_category "$cmd_file")
            
            jq --arg filename "$filename" \
               --arg version "$version" \
               --arg category "$category" \
               --arg date "$update_date" \
               '.installed_files[$filename] = {
                   "version": $version,
                   "category": $category,
                   "installed_date": (.installed_files[$filename].installed_date // $date),
                   "last_updated": $date,
                   "source_path": "commands/\($category)/\($filename)"
               }' "$MANIFEST_FILE" > "$MANIFEST_FILE.tmp"
            mv "$MANIFEST_FILE.tmp" "$MANIFEST_FILE"
        fi
    done
    
    # Update CLAUDE.md version if present
    if [[ -f "$CLAUDE_DIR/CLAUDE.md" ]]; then
        local claude_version=$(extract_version "$CLAUDE_DIR/CLAUDE.md")
        jq --arg version "$claude_version" \
           --arg date "$update_date" \
           '.claude_md.version = $version | .claude_md.last_updated = $date' \
           "$MANIFEST_FILE" > "$MANIFEST_FILE.tmp"
        mv "$MANIFEST_FILE.tmp" "$MANIFEST_FILE"
    fi
    
    log_success "Manifest updated"
}

cleanup_temp_files() {
    rm -f /tmp/re4c_updates /tmp/re4c_new_files /tmp/re4c_obsolete_files
}

print_summary() {
    local new_version=$(get_repo_version)
    
    echo ""
    log_success "re4c update complete!"
    echo ""
    echo "📊 Update Summary:"
    echo "   - Updated to version: $new_version"
    echo "   - Backups stored in: $BACKUP_DIR"
    echo "   - Manifest updated: $(date)"
    echo ""
    echo "🚀 What's Next:"
    echo "   - Your commands are now up to date"
    echo "   - Check the docs/ directory for new documentation"
    echo "   - Run this script again anytime to check for updates"
    echo ""
}

# Main update flow
main() {
    local auto_mode=""
    
    # Parse command line arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            --auto|-a)
                auto_mode="auto"
                shift
                ;;
            --help|-h)
                echo "Usage: $0 [--auto|-a] [--help|-h]"
                echo ""
                echo "Options:"
                echo "  --auto, -a     Run update in automatic mode (no prompts)"
                echo "  --help, -h     Show this help message"
                exit 0
                ;;
            *)
                log_error "Unknown option: $1"
                exit 1
                ;;
        esac
    done
    
    print_header
    check_installation
    
    if [[ "$auto_mode" == "auto" ]]; then
        log_info "Running in automatic mode..."
    fi
    
    check_for_updates
    analyze_updates
    
    # Confirm before proceeding
    if [[ "$auto_mode" != "auto" ]]; then
        echo ""
        read -p "Proceed with update? (y/n): " proceed
        if [[ ! "$proceed" =~ ^[Yy]$ ]]; then
            log_info "Update cancelled by user"
            exit 0
        fi
    fi
    
    echo ""
    log_info "Starting update process..."
    
    apply_updates "$auto_mode"
    update_claude_md "$auto_mode"
    update_manifest
    cleanup_temp_files
    
    print_summary
    log_success "Update completed successfully!"
}

# Check if script is being sourced or executed
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi