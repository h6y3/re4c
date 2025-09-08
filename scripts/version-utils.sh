#!/bin/bash

# re4c Version Utilities
# Handles version comparison, extraction, and management

# Extract version from file frontmatter
extract_version() {
    local file="$1"
    if [[ -f "$file" ]]; then
        grep "^version:" "$file" | head -1 | sed 's/version: *"*\([^"]*\)"*.*/\1/'
    fi
}

# Extract re4c_version from file frontmatter  
extract_re4c_version() {
    local file="$1"
    if [[ -f "$file" ]]; then
        grep "^re4c_version:" "$file" | head -1 | sed 's/re4c_version: *"*\([^"]*\)"*.*/\1/'
    fi
}

# Extract category from file frontmatter
extract_category() {
    local file="$1"
    if [[ -f "$file" ]]; then
        grep "^category:" "$file" | head -1 | sed 's/category: *"*\([^"]*\)"*.*/\1/'
    fi
}

# Compare semantic versions (returns: -1, 0, 1 for less, equal, greater)
compare_versions() {
    local version1="$1"
    local version2="$2"
    
    # Handle empty versions
    [[ -z "$version1" ]] && version1="0.0.0"
    [[ -z "$version2" ]] && version2="0.0.0"
    
    # Split versions into arrays
    IFS='.' read -ra V1 <<< "$version1"
    IFS='.' read -ra V2 <<< "$version2"
    
    # Pad arrays to ensure 3 elements
    while [[ ${#V1[@]} -lt 3 ]]; do V1+=("0"); done
    while [[ ${#V2[@]} -lt 3 ]]; do V2+=("0"); done
    
    # Compare each component
    for i in {0..2}; do
        if [[ ${V1[i]} -lt ${V2[i]} ]]; then
            echo "-1"
            return
        elif [[ ${V1[i]} -gt ${V2[i]} ]]; then
            echo "1" 
            return
        fi
    done
    
    echo "0"
}

# Check if version1 is newer than version2
is_newer_version() {
    local result=$(compare_versions "$1" "$2")
    [[ "$result" == "1" ]]
}

# Generate timestamp for backups
generate_timestamp() {
    date "+%Y-%m-%d_%H-%M-%S"
}

# Backup file with timestamp
backup_file() {
    local source_file="$1"
    local backup_dir="$2"
    
    if [[ -f "$source_file" ]]; then
        local filename=$(basename "$source_file")
        local timestamp=$(generate_timestamp)
        local backup_path="${backup_dir}/${filename}.backup.${timestamp}"
        
        mkdir -p "$backup_dir"
        cp "$source_file" "$backup_path"
        echo "$backup_path"
    fi
}

# Update frontmatter version in file
update_file_version() {
    local file="$1"
    local new_version="$2"
    local new_re4c_version="$3"
    local today=$(date "+%Y-%m-%d")
    
    if [[ -f "$file" ]]; then
        # Use sed to update version fields
        sed -i.tmp \
            -e "s/^version: .*/version: \"$new_version\"/" \
            -e "s/^re4c_version: .*/re4c_version: \"$new_re4c_version\"/" \
            -e "s/^last_updated: .*/last_updated: \"$today\"/" \
            "$file"
        rm -f "${file}.tmp"
    fi
}

# Validate version format (semantic versioning)
validate_version() {
    local version="$1"
    if [[ $version =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        return 0
    else
        return 1
    fi
}