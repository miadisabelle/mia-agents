#!/bin/bash
# Build script to consolidate all agent roles into a single markdown file
# Usage: ./build-all-agents.sh

set -e

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DIST_DIR="${SCRIPT_DIR}/dist"
OUTPUT_FILE="${DIST_DIR}/mia-agents-all.md"

# Create dist directory if it doesn't exist
mkdir -p "${DIST_DIR}"

# Initialize output file with header
cat > "${OUTPUT_FILE}" << 'EOF'
# Mia Agents - Complete Agent Roles Collection

This document contains all agent roles available in the Mia Agents ecosystem.

**Generated:** $(date '+%Y-%m-%d %H:%M:%S')

**Total Agents:** TBD

---

## Table of Contents

EOF

# Collect all agent files (excluding special files)
declare -a agent_files
while IFS= read -r -d '' file; do
    filename=$(basename "$file" .md)
    # Exclude special files
    if [[ ! "$filename" =~ ^(README|FEATURES|ROADMAP|SPIRALS|GEMINI|research-notes-.*)$ ]]; then
        agent_files+=("$file")
    fi
done < <(find "${SCRIPT_DIR}" -maxdepth 1 -name "*.md" -type f -print0 | sort -z)

# Count total agents
total_agents=${#agent_files[@]}

# Generate table of contents
echo "Generating table of contents..."
for file in "${agent_files[@]}"; do
    filename=$(basename "$file" .md)
    # Extract name and description from frontmatter
    name=$(sed -n 's/^name: \(.*\)/\1/p' "$file" | head -1)
    description=$(sed -n 's/^description: \(.*\)/\1/p' "$file" | head -1)

    if [[ -n "$name" ]]; then
        echo "- [$name](#${name//[^a-zA-Z0-9-]/-})" >> "${OUTPUT_FILE}"
    else
        echo "- [$filename](#${filename//[^a-zA-Z0-9-]/-})" >> "${OUTPUT_FILE}"
    fi
done

# Update total count
sed -i "s/\*\*Total Agents:\*\* TBD/\*\*Total Agents:\*\* ${total_agents}/" "${OUTPUT_FILE}"

echo "" >> "${OUTPUT_FILE}"
echo "---" >> "${OUTPUT_FILE}"
echo "" >> "${OUTPUT_FILE}"

# Process each agent file
echo "Processing agent files..."
for file in "${agent_files[@]}"; do
    filename=$(basename "$file" .md)
    echo "Processing: $filename"

    # Extract frontmatter data
    name=$(sed -n 's/^name: \(.*\)/\1/p' "$file" | head -1)
    description=$(sed -n 's/^description: \(.*\)/\1/p' "$file" | head -1)
    model=$(sed -n 's/^model: \(.*\)/\1/p' "$file" | head -1)

    # Add agent section
    echo "## ${name:-$filename}" >> "${OUTPUT_FILE}"
    echo "" >> "${OUTPUT_FILE}"

    if [[ -n "$description" ]]; then
        echo "**Description:** $description" >> "${OUTPUT_FILE}"
        echo "" >> "${OUTPUT_FILE}"
    fi

    if [[ -n "$model" ]]; then
        echo "**Model:** $model" >> "${OUTPUT_FILE}"
        echo "" >> "${OUTPUT_FILE}"
    fi

    # Extract content after frontmatter (skip first 5 lines which contain ---)
    in_frontmatter=false
    frontmatter_ended=false

    while IFS= read -r line; do
        if [[ "$line" == "---" ]]; then
            if [[ "$in_frontmatter" == "false" ]]; then
                in_frontmatter=true
            else
                frontmatter_ended=true
                continue
            fi
        elif [[ "$frontmatter_ended" == "true" ]]; then
            echo "$line" >> "${OUTPUT_FILE}"
        fi
    done < "$file"

    echo "" >> "${OUTPUT_FILE}"
    echo "---" >> "${OUTPUT_FILE}"
    echo "" >> "${OUTPUT_FILE}"
done

echo ""
echo "✅ Build complete!"
echo "📄 Output: ${OUTPUT_FILE}"
echo "📊 Total agents: ${total_agents}"
echo ""
