#!/bin/bash
# Build script to group agent roles semantically
# Usage: ./build-semantic-groups.sh

set -e

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DIST_DIR="${SCRIPT_DIR}/dist"

# Create dist directory if it doesn't exist
mkdir -p "${DIST_DIR}"

# Define semantic categories and their patterns
declare -A categories

categories[development]="ai-engineer backend-architect frontend-developer mobile-developer ios-developer flutter-expert unity-developer"
categories[languages]="python-pro javascript-pro typescript-pro java-pro golang-pro rust-pro ruby-pro php-pro cpp-pro csharp-pro c-pro scala-pro elixir-pro sql-pro"
categories[devops]="deployment-engineer devops-troubleshooter cloud-architect terraform-specialist network-engineer incident-responder"
categories[data]="data-engineer data-scientist database-admin database-optimizer ml-engineer mlops-engineer quant-analyst"
categories[quality]="code-reviewer test-automator debugger error-detective performance-engineer security-auditor"
categories[architecture]="architect-review docs-architect graphql-architect dx-optimizer context-manager"
categories[seo]="seo-keyword-strategist seo-content-planner seo-content-writer seo-content-auditor seo-content-refresher seo-meta-optimizer seo-structure-architect seo-snippet-hunter seo-authority-builder seo-cannibalization-detector search-specialist"
categories[business]="business-analyst hr-pro legal-advisor risk-manager sales-automator content-marketer customer-support payment-integration"
categories[specialization]="api-documenter mermaid-expert minecraft-bukkit-pro legacy-modernizer tutorial-engineer prompt-engineer reference-builder"
categories[persona]="persona-corpus-generator persona-synthesis-orchestrator persona-hub-architect poly-modal-persona-designer synthetic-data-composer"
categories[education]="genai-education-scaffolding"
categories[research]="reality-narrative-researcher"
categories[system]="Conductor Clarion_The_System_Cartographer_Instructions ios-screen-observer"

# Function to extract content after frontmatter
extract_content() {
    local file=$1
    awk '
        BEGIN { in_front=0; front_count=0 }
        /^---$/ {
            front_count++
            if (front_count == 2) in_front=1
            next
        }
        in_front { print }
    ' "$file"
}

# Function to build a category file
build_category() {
    local category=$1
    local agents=$2
    local output_file="${DIST_DIR}/mia-agents-${category}.md"
    local temp_file="${DIST_DIR}/.temp-${category}.md"

    echo "Building category: ${category}"

    # Process each agent in the category
    local count=0
    > "$temp_file"  # Clear temp file

    for agent_name in $agents; do
        agent_file="${SCRIPT_DIR}/${agent_name}.md"

        if [[ -f "$agent_file" ]]; then
            ((count++))

            # Extract frontmatter data
            name=$(grep "^name:" "$agent_file" | head -1 | cut -d: -f2- | sed 's/^ *//')
            description=$(grep "^description:" "$agent_file" | head -1 | cut -d: -f2- | sed 's/^ *//')
            model=$(grep "^model:" "$agent_file" | head -1 | cut -d: -f2- | sed 's/^ *//')

            # Write agent section to temp file
            {
                echo "## ${name:-$agent_name}"
                echo ""

                if [[ -n "$description" ]]; then
                    echo "**Description:** $description"
                    echo ""
                fi

                if [[ -n "$model" ]]; then
                    echo "**Model:** $model"
                    echo ""
                fi

                # Extract and add content after frontmatter
                extract_content "$agent_file"
                echo ""
                echo "---"
                echo ""
            } >> "$temp_file"
        fi
    done

    # Write the complete file with header + temp content
    cat > "${output_file}" << EOF
# Mia Agents - ${category^} Team

**Total Agents:** ${count}

This document contains all agents in the **${category}** category.

**Generated:** $(date '+%Y-%m-%d %H:%M:%S')

---

## Agents in this Category

EOF
    cat "$temp_file" >> "${output_file}"
    rm -f "$temp_file"

    echo "  → ${count} agents found"
}

# Build each category
echo ""
echo "Building semantic agent groups..."
echo ""

for category in "${!categories[@]}"; do
    build_category "$category" "${categories[$category]}"
done

# Create an index file
INDEX_FILE="${DIST_DIR}/mia-agents-index.md"
cat > "${INDEX_FILE}" << 'EOF'
# Mia Agents - Semantic Index

This index organizes all agents by semantic categories.

**Generated:** $(date '+%Y-%m-%d %H:%M:%S')

---

## Categories

EOF

echo "### Development" >> "${INDEX_FILE}"
echo "Core development roles focused on building applications" >> "${INDEX_FILE}"
echo "→ [View Development Team](mia-agents-development.md)" >> "${INDEX_FILE}"
echo "" >> "${INDEX_FILE}"

echo "### Languages" >> "${INDEX_FILE}"
echo "Language-specific programming experts" >> "${INDEX_FILE}"
echo "→ [View Languages Team](mia-agents-languages.md)" >> "${INDEX_FILE}"
echo "" >> "${INDEX_FILE}"

echo "### DevOps" >> "${INDEX_FILE}"
echo "Infrastructure, deployment, and operations specialists" >> "${INDEX_FILE}"
echo "→ [View DevOps Team](mia-agents-devops.md)" >> "${INDEX_FILE}"
echo "" >> "${INDEX_FILE}"

echo "### Data" >> "${INDEX_FILE}"
echo "Data engineering, science, and machine learning experts" >> "${INDEX_FILE}"
echo "→ [View Data Team](mia-agents-data.md)" >> "${INDEX_FILE}"
echo "" >> "${INDEX_FILE}"

echo "### Quality" >> "${INDEX_FILE}"
echo "Testing, debugging, and quality assurance specialists" >> "${INDEX_FILE}"
echo "→ [View Quality Team](mia-agents-quality.md)" >> "${INDEX_FILE}"
echo "" >> "${INDEX_FILE}"

echo "### Architecture" >> "${INDEX_FILE}"
echo "System architecture and design experts" >> "${INDEX_FILE}"
echo "→ [View Architecture Team](mia-agents-architecture.md)" >> "${INDEX_FILE}"
echo "" >> "${INDEX_FILE}"

echo "### SEO" >> "${INDEX_FILE}"
echo "Search engine optimization and content strategy specialists" >> "${INDEX_FILE}"
echo "→ [View SEO Team](mia-agents-seo.md)" >> "${INDEX_FILE}"
echo "" >> "${INDEX_FILE}"

echo "### Business" >> "${INDEX_FILE}"
echo "Business operations and support roles" >> "${INDEX_FILE}"
echo "→ [View Business Team](mia-agents-business.md)" >> "${INDEX_FILE}"
echo "" >> "${INDEX_FILE}"

echo "### Specialization" >> "${INDEX_FILE}"
echo "Specialized and niche expertise areas" >> "${INDEX_FILE}"
echo "→ [View Specialization Team](mia-agents-specialization.md)" >> "${INDEX_FILE}"
echo "" >> "${INDEX_FILE}"

echo "### Persona" >> "${INDEX_FILE}"
echo "Persona design and synthesis experts" >> "${INDEX_FILE}"
echo "→ [View Persona Team](mia-agents-persona.md)" >> "${INDEX_FILE}"
echo "" >> "${INDEX_FILE}"

echo "### Education" >> "${INDEX_FILE}"
echo "Educational and scaffolding agents" >> "${INDEX_FILE}"
echo "→ [View Education Team](mia-agents-education.md)" >> "${INDEX_FILE}"
echo "" >> "${INDEX_FILE}"

echo "### Research" >> "${INDEX_FILE}"
echo "Research and analysis specialists" >> "${INDEX_FILE}"
echo "→ [View Research Team](mia-agents-research.md)" >> "${INDEX_FILE}"
echo "" >> "${INDEX_FILE}"

echo "### System" >> "${INDEX_FILE}"
echo "System orchestration and coordination agents" >> "${INDEX_FILE}"
echo "→ [View System Team](mia-agents-system.md)" >> "${INDEX_FILE}"
echo "" >> "${INDEX_FILE}"

echo ""
echo "✅ Semantic grouping complete!"
echo "📄 Files generated in: ${DIST_DIR}"
echo "📊 Categories: ${#categories[@]}"
echo ""
