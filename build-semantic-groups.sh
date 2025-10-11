#!/bin/bash
# Build semantic groups - simplified version
set -e

DIST_DIR="./dist"
mkdir -p "$DIST_DIR"

# Just build one simple category file as a test
echo "Building Development team..."
cat > "$DIST_DIR/mia-agents-development.md" << 'EOF'
# Mia Agents - Development Team

This document contains agents in the development category.

---

EOF

# Append each agent
for agent in ai-engineer backend-architect frontend-developer mobile-developer ios-developer flutter-expert unity-developer; do
    if [[ -f "${agent}.md" ]]; then
        echo "Processing $agent..."
        # Just copy the whole file content after frontmatter
        awk 'BEGIN{p=0} /^---$/{c++; if(c==2){p=1;next}} p{print}' "${agent}.md" >> "$DIST_DIR/mia-agents-development.md"
        echo -e "\n---\n" >> "$DIST_DIR/mia-agents-development.md"
    fi
done

echo "✅ Created mia-agents-development.md"
echo ""
echo "The full semantic grouping script had issues. For now:"
echo "- Use build-all-agents.sh to create the complete collection"
echo "- Individual category files can be created with similar simple scripts"
