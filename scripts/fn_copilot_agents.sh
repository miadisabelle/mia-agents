#!/bin/bash

################################################################################
# 🧠 GitHub Copilot Agent Launcher Functions
#
# Simple, cheap task functions for development pipeline automation.
# Uses gpt-5-mini (cheap/fast) by default for most tasks.
#
# Usage:
#   source ./scripts/fn_copilot_agents.sh
#   copilot_index "logs/"           # Index files in directory
#   copilot_summarize "README.md"   # Summarize a file
#   copilot_review                  # Quick code review
#
################################################################################

# Default cheap model for simple tasks
: ${COPILOT_CHEAP_MODEL:="gpt-5-mini"}
: ${COPILOT_STANDARD_MODEL:="sonnet"}

################################################################################
# 📋 SIMPLE AUTOMATABLE TASKS (cheap, pipeline-friendly)
################################################################################

# Index files in a directory with summaries
copilot_index() {
    local target_dir="${1:-.}"
    local output_file="${2:-INDEX.md}"
    shift 2 2>/dev/null || true
    
    copilot -p "Create or update $output_file with an index of all files in @$target_dir - include brief summaries in a markdown table" \
        --model "$COPILOT_CHEAP_MODEL" \
        --yolo \
        "$@"
}

# Summarize a file or directory
copilot_summarize() {
    local target="$1"
    shift
    
    if [ -z "$target" ]; then
        echo "Usage: copilot_summarize <file_or_dir> [args]"
        return 1
    fi
    
    copilot -p "Summarize @$target in 3-5 bullet points" \
        --model "$COPILOT_CHEAP_MODEL" \
        --yolo \
        "$@"
}

# Generate commit message from staged changes
copilot_commit_msg() {
    copilot -p "Generate a conventional commit message for the staged changes. Output only the commit message, nothing else." \
        --model "$COPILOT_CHEAP_MODEL" \
        --yolo \
        "$@"
}

# Quick lint check with suggestions
copilot_lint() {
    local target="${1:-.}"
    shift 2>/dev/null || true
    
    copilot -p "Quick lint check on @$target - list issues briefly" \
        --model "$COPILOT_CHEAP_MODEL" \
        --yolo \
        "$@"
}

# Generate TODO from code comments
copilot_todos() {
    local target="${1:-.}"
    shift 2>/dev/null || true
    
    copilot -p "Extract all TODO/FIXME/HACK comments from @$target into a markdown checklist" \
        --model "$COPILOT_CHEAP_MODEL" \
        --yolo \
        "$@"
}

# Quick diff summary
copilot_diff_summary() {
    copilot -p "Summarize the recent git changes in 2-3 sentences" \
        --model "$COPILOT_CHEAP_MODEL" \
        --yolo \
        "$@"
}

################################################################################
# 🔧 STANDARD TASKS (balanced cost/quality)
################################################################################

# Quick code review (standard model)
copilot_review() {
    local _prompt="${1:-Review recent changes}"
    shift 2>/dev/null || true
    
    copilot -p "$_prompt" \
        --agents '[{"source":"./agents/code-reviewer.md"}]' \
        --model "$COPILOT_STANDARD_MODEL" \
        "$@"
}

# Debug assistance
copilot_debug() {
    local _prompt="${1:-Analyze recent errors}"
    shift 2>/dev/null || true
    
    copilot -p "$_prompt" \
        --agents '[{"source":"./agents/debugger.md"}]' \
        --model "$COPILOT_STANDARD_MODEL" \
        "$@"
}

# DevOps troubleshooting
copilot_troubleshoot() {
    local _prompt="${1:-Troubleshoot recent issues}"
    shift 2>/dev/null || true
    
    copilot -p "$_prompt" \
        --agents '[{"source":"./agents/devops-troubleshooter.md"}]' \
        --model "$COPILOT_STANDARD_MODEL" \
        "$@"
}

################################################################################
# 🏗️ PREMIUM TASKS (use sparingly - high cost)
################################################################################

# Architecture review (premium - use sparingly)
copilot_architect() {
    local _prompt="${1:-Review architecture}"
    shift 2>/dev/null || true
    
    echo "⚠️  Using premium model (opus) - consider --model sonnet for cheaper option"
    copilot -p "$_prompt" \
        --agents '[{"source":"./agents/architect-review.md"}]' \
        --model opus \
        "$@"
}

# Documentation generation (premium - use sparingly)
copilot_docs() {
    local _prompt="${1:-Document this system}"
    shift 2>/dev/null || true
    
    echo "⚠️  Using premium model (opus) - consider --model sonnet for cheaper option"
    copilot -p "$_prompt" \
        --agents '[{"source":"./agents/docs-architect.md"}]' \
        --model opus \
        "$@"
}

################################################################################
# 📋 Utility Functions
################################################################################

copilot_agents_list() {
    cat << 'EOF'
GitHub Copilot Agent Functions

📋 CHEAP TASKS (gpt-5-mini, pipeline-friendly):
  copilot_index <dir> [output]    Index files with summaries
  copilot_summarize <target>      Summarize file/dir in bullets
  copilot_commit_msg              Generate commit message
  copilot_lint [target]           Quick lint check
  copilot_todos [target]          Extract TODO/FIXME comments
  copilot_diff_summary            Summarize git changes

🔧 STANDARD TASKS (sonnet):
  copilot_review [prompt]         Code review
  copilot_debug [prompt]          Debug assistance
  copilot_troubleshoot [prompt]   DevOps troubleshooting

🏗️ PREMIUM TASKS (opus - use sparingly):
  copilot_architect [prompt]      Architecture review
  copilot_docs [prompt]           Documentation generation

Override models: COPILOT_CHEAP_MODEL=haiku COPILOT_STANDARD_MODEL=haiku
EOF
}

copilot_agents_help() {
    copilot_agents_list
}

################################################################################
# Export Functions
################################################################################

export -f copilot_index
export -f copilot_summarize
export -f copilot_commit_msg
export -f copilot_lint
export -f copilot_todos
export -f copilot_diff_summary
export -f copilot_review
export -f copilot_debug
export -f copilot_troubleshoot
export -f copilot_architect
export -f copilot_docs
export -f copilot_agents_list
export -f copilot_agents_help

# Print notice on source
if [ "${BASH_SOURCE[0]}" = "${0}" ]; then
    echo "Source this file: source ./scripts/fn_copilot_agents.sh"
    exit 1
fi

echo "🧠 Copilot Agent Functions Loaded (copilot_agents_list for help)"
