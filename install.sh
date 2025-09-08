#!/bin/bash

# re4c (Rapid Engineering For Claude) Installation Script
# Installs commands and CLAUDE.md with conflict resolution

set -e

# Configuration
RE4C_VERSION="1.1.0"
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
    echo "re4c Installation - Rapid Engineering For Claude v$RE4C_VERSION"
    echo ""
}

check_prerequisites() {
    log_info "Checking prerequisites..."
    
    # Check if running on macOS or Linux
    if [[ "$OSTYPE" != "darwin"* ]] && [[ "$OSTYPE" != "linux-gnu"* ]]; then
        log_error "Unsupported operating system: $OSTYPE"
        log_error "re4c currently supports macOS and Linux only"
        exit 1
    fi
    
    # Check for required commands
    for cmd in jq; do
        if ! command -v $cmd &> /dev/null; then
            log_error "Required command '$cmd' not found"
            log_info "Please install $cmd and try again"
            exit 1
        fi
    done
    
    log_success "Prerequisites check passed"
}

setup_directories() {
    log_info "Setting up directories..."
    
    mkdir -p "$CLAUDE_DIR"
    mkdir -p "$COMMANDS_DIR" 
    mkdir -p "$BACKUP_DIR"
    
    log_success "Directories created"
}

backup_existing_file() {
    local source_file="$1"
    local backup_name="$2"
    
    if [[ -f "$source_file" ]]; then
        local timestamp=$(generate_timestamp)
        local backup_path="$BACKUP_DIR/${backup_name}.backup.${timestamp}"
        cp "$source_file" "$backup_path"
        log_success "Backed up to: $backup_path"
        echo "$backup_path"
    fi
}

handle_claude_md_conflict() {
    local existing_claude="$CLAUDE_DIR/CLAUDE.md"
    local new_claude="$SCRIPT_DIR/templates/CLAUDE.md"
    
    if [[ ! -f "$existing_claude" ]]; then
        # No conflict, just install
        cp "$new_claude" "$existing_claude"
        log_success "Installed CLAUDE.md"
        return 0
    fi
    
    # Check if versions are identical
    local existing_version=$(extract_version "$existing_claude")
    local new_version=$(extract_version "$new_claude")
    
    if [[ "$existing_version" == "$new_version" ]]; then
        log_info "CLAUDE.md version $existing_version already installed"
        return 0
    fi
    
    log_warning "Existing CLAUDE.md found"
    echo "  Current version: $existing_version"
    echo "  New version:     $new_version"
    echo ""
    echo "Choose an option:"
    echo "  1) Backup existing and install new version"
    echo "  2) Keep existing version (skip installation)"
    echo "  3) View differences before deciding"
    
    while true; do
        read -p "Enter choice [1-3]: " choice
        case $choice in
            1)
                local backup_path=$(backup_existing_file "$existing_claude" "CLAUDE.md")
                cp "$new_claude" "$existing_claude"
                log_success "CLAUDE.md updated (backup: $backup_path)"
                return 0
                ;;
            2)
                log_info "Keeping existing CLAUDE.md"
                return 1
                ;;
            3)
                echo "--- Differences (- existing, + new) ---"
                diff -u "$existing_claude" "$new_claude" || true
                echo "--- End of differences ---"
                echo ""
                ;;
            *)
                log_warning "Please enter 1, 2, or 3"
                ;;
        esac
    done
}

handle_command_conflicts() {
    local category="$1"
    local source_dir="$SCRIPT_DIR/commands/$category"
    local conflicts=()
    local new_commands=()
    local updates=()
    
    # Scan for conflicts and categorize
    for source_file in "$source_dir"/*.md; do
        if [[ -f "$source_file" ]]; then
            local filename=$(basename "$source_file")
            local dest_file="$COMMANDS_DIR/$filename"
            
            if [[ -f "$dest_file" ]]; then
                local existing_version=$(extract_version "$dest_file")
                local new_version=$(extract_version "$source_file")
                
                if [[ -z "$existing_version" ]]; then
                    conflicts+=("$filename")
                elif [[ $(compare_versions "$new_version" "$existing_version") == "1" ]]; then
                    updates+=("$filename")
                # else: same version or older, skip
                fi
            else
                new_commands+=("$filename")
            fi
        fi
    done
    
    # Handle new commands (no conflicts)
    for cmd in "${new_commands[@]}"; do
        cp "$source_dir/$cmd" "$COMMANDS_DIR/$cmd"
        log_success "Installed new command: $cmd"
    done
    
    # Handle updates
    for cmd in "${updates[@]}"; do
        local existing_version=$(extract_version "$COMMANDS_DIR/$cmd")
        local new_version=$(extract_version "$source_dir/$cmd")
        
        log_info "Update available for $cmd: $existing_version → $new_version"
        
        while true; do
            read -p "Update $cmd? (y/n/d for diff): " choice
            case $choice in
                y|Y)
                    local backup_path=$(backup_existing_file "$COMMANDS_DIR/$cmd" "$cmd")
                    cp "$source_dir/$cmd" "$COMMANDS_DIR/$cmd"
                    log_success "Updated $cmd (backup: $backup_path)"
                    break
                    ;;
                n|N)
                    log_info "Skipped updating $cmd"
                    break
                    ;;
                d|D)
                    echo "--- Differences (- existing, + new) ---"
                    diff -u "$COMMANDS_DIR/$cmd" "$source_dir/$cmd" || true
                    echo "--- End of differences ---"
                    ;;
                *)
                    log_warning "Please enter y, n, or d"
                    ;;
            esac
        done
    done
    
    # Handle conflicts (no version info)
    for cmd in "${conflicts[@]}"; do
        log_warning "Conflict detected for $cmd (no version information)"
        
        while true; do
            read -p "Replace $cmd? (y/n/d for diff): " choice
            case $choice in
                y|Y)
                    local backup_path=$(backup_existing_file "$COMMANDS_DIR/$cmd" "$cmd")
                    cp "$source_dir/$cmd" "$COMMANDS_DIR/$cmd"
                    log_success "Replaced $cmd (backup: $backup_path)"
                    break
                    ;;
                n|N)
                    log_info "Kept existing $cmd"
                    break
                    ;;
                d|D)
                    echo "--- Differences (- existing, + new) ---"
                    diff -u "$COMMANDS_DIR/$cmd" "$source_dir/$cmd" || true
                    echo "--- End of differences ---"
                    ;;
                *)
                    log_warning "Please enter y, n, or d"
                    ;;
            esac
        done
    done
}

install_commands() {
    log_info "Installing commands..."
    
    # Install commands by category
    for category in core validation development deployment documentation; do
        if [[ -d "$SCRIPT_DIR/commands/$category" ]]; then
            log_info "Processing $category commands..."
            handle_command_conflicts "$category"
        fi
    done
    
    log_success "Command installation complete"
}

create_manifest() {
    log_info "Creating installation manifest..."
    
    local manifest_data=$(cat <<EOF
{
    "re4c_version": "$RE4C_VERSION",
    "installation_date": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")",
    "last_update_check": null,
    "install_location": "$CLAUDE_DIR",
    "installed_files": {},
    "claude_md": {
        "version": null,
        "installed_date": null,
        "backup_path": null,
        "customized": false
    },
    "installation_options": {
        "auto_backup": true,
        "interactive_conflicts": true,
        "preserve_customizations": true
    }
}
EOF
)
    
    echo "$manifest_data" > "$MANIFEST_FILE"
    
    # Update manifest with actual installed files
    for cmd_file in "$COMMANDS_DIR"/*.md; do
        if [[ -f "$cmd_file" ]]; then
            local filename=$(basename "$cmd_file")
            local version=$(extract_version "$cmd_file")
            local category=$(extract_category "$cmd_file")
            
            # Update manifest using jq
            jq --arg filename "$filename" \
               --arg version "$version" \
               --arg category "$category" \
               --arg date "$(date -u +"%Y-%m-%dT%H:%M:%SZ")" \
               '.installed_files[$filename] = {
                   "version": $version,
                   "category": $category,
                   "installed_date": $date,
                   "source_path": "commands/\($category)/\($filename)"
               }' "$MANIFEST_FILE" > "$MANIFEST_FILE.tmp"
            
            mv "$MANIFEST_FILE.tmp" "$MANIFEST_FILE"
        fi
    done
    
    # Update CLAUDE.md info if installed
    if [[ -f "$CLAUDE_DIR/CLAUDE.md" ]]; then
        local claude_version=$(extract_version "$CLAUDE_DIR/CLAUDE.md")
        jq --arg version "$claude_version" \
           --arg date "$(date -u +"%Y-%m-%dT%H:%M:%SZ")" \
           '.claude_md.version = $version | .claude_md.installed_date = $date' \
           "$MANIFEST_FILE" > "$MANIFEST_FILE.tmp"
        mv "$MANIFEST_FILE.tmp" "$MANIFEST_FILE"
    fi
    
    log_success "Installation manifest created"
}

print_summary() {
    echo ""
    log_success "re4c installation complete!"
    echo ""
    echo "📊 Installation Summary:"
    echo "   - Commands directory: $COMMANDS_DIR"
    echo "   - Global config: $CLAUDE_DIR/CLAUDE.md"
    echo "   - Backups directory: $BACKUP_DIR" 
    echo "   - Manifest file: $MANIFEST_FILE"
    echo ""
    echo "🚀 Quick Start:"
    echo "   - Commands are now available in Claude Code"
    echo "   - Global workflow standards are in place"
    echo "   - Run 'bash $SCRIPT_DIR/update.sh' to check for updates"
    echo ""
    echo "📚 Documentation:"
    echo "   - See README.md for detailed usage instructions"
    echo "   - Check the docs/ directory for additional information"
    echo ""
}

# Main installation flow
main() {
    print_header
    check_prerequisites
    setup_directories
    
    log_info "Starting installation process..."
    echo ""
    
    # Handle CLAUDE.md
    handle_claude_md_conflict
    
    # Install commands
    install_commands
    
    # Create manifest
    create_manifest
    
    # Show summary
    print_summary
    
    log_success "Installation completed successfully!"
}

# Check if script is being sourced or executed
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi