#!/bin/bash

################################################################################
# 🧠 Claude Specialized Agent Launcher Functions
#
# This file provides bash functions to quickly launch Claude with specific
# agents. Each function handles agent loading, MCP config, and session management.
#
# Usage:
#   source ./scripts/fn_claude_agents.sh
#   claude_review "your prompt here"
#   claude_debug "your debug query"
#   claude_architect "architecture question"
#
# All functions support pass-through arguments to `claude` command.
################################################################################

# Ensure we're in the right context
: ${SESSION_ROOT_DIR:="/src/_sessiondata"}
: ${SESSION_ID_PREFIX:="session_id_"}
: ${MCP_CONFIG:="/src/.mcp.coaiapy.env.aetherial.json"}

################################################################################
# 🔍 Code Reviewer - Quality, Security, Configuration Analysis
################################################################################
claude_review() {
    local _prompt="$1"
    shift

    if [ -z "$_prompt" ]; then
        echo "🔍 Code Reviewer Agent"
        echo "Usage: claude_review '<prompt>' [additional args]"
        echo ""
        echo "Examples:"
        echo "  claude_review 'Review my recent changes'"
        echo "  claude_review 'Check for security issues in config' --add-dir ./config"
        return 1
    fi

    claude "$_prompt" \
        --agents '[{"source":"./agents/code-reviewer.md"}]' \
        --mcp-config "$MCP_CONFIG" \
        "$@"
}

################################################################################
# 🔴 Debugger - Root Cause Analysis, Structural Problem Solving
################################################################################
claude_debug() {
    local _prompt="$1"
    shift

    if [ -z "$_prompt" ]; then
        echo "🔴 Debugger Agent"
        echo "Usage: claude_debug '<prompt>' [additional args]"
        echo ""
        echo "Examples:"
        echo "  claude_debug 'Why is this test failing?'"
        echo "  claude_debug 'Analyze this error trace' --add-dir ./logs"
        return 1
    fi

    claude "$_prompt" \
        --agents '[{"source":"./agents/debugger.md"}]' \
        --mcp-config "$MCP_CONFIG" \
        "$@"
}

################################################################################
# 🏗️ Architect Reviewer - Architecture, Design Patterns, SOLID Principles
################################################################################
claude_architect() {
    local _prompt="$1"
    shift

    if [ -z "$_prompt" ]; then
        echo "🏗️ Architect Reviewer Agent"
        echo "Usage: claude_architect '<prompt>' [additional args]"
        echo ""
        echo "Examples:"
        echo "  claude_architect 'Review the system architecture'"
        echo "  claude_architect 'Check for SOLID principle violations'"
        return 1
    fi

    claude "$_prompt" \
        --agents '[{"source":"./agents/architect-review.md"}]' \
        --mcp-config "$MCP_CONFIG" \
        "$@"
}

################################################################################
# 📚 API Documenter - OpenAPI, SDKs, Developer Experience
################################################################################
claude_apidoc() {
    local _prompt="$1"
    shift

    if [ -z "$_prompt" ]; then
        echo "📚 API Documenter Agent"
        echo "Usage: claude_apidoc '<prompt>' [additional args]"
        echo ""
        echo "Examples:"
        echo "  claude_apidoc 'Generate OpenAPI spec for my API'"
        echo "  claude_apidoc 'Create SDK documentation' --add-dir ./src/api"
        return 1
    fi

    claude "$_prompt" \
        --agents '[{"source":"./agents/api-documenter.md"}]' \
        --mcp-config "$MCP_CONFIG" \
        "$@"
}

################################################################################
# 🎨 Frontend Developer - React, Components, Responsive Design, Accessibility
################################################################################
claude_frontend() {
    local _prompt="$1"
    shift

    if [ -z "$_prompt" ]; then
        echo "🎨 Frontend Developer Agent"
        echo "Usage: claude_frontend '<prompt>' [additional args]"
        echo ""
        echo "Examples:"
        echo "  claude_frontend 'Build a modal component'"
        echo "  claude_frontend 'Fix accessibility issues' --add-dir ./components"
        return 1
    fi

    claude "$_prompt" \
        --agents '[{"source":"./agents/frontend-developer.md"}]' \
        --mcp-config "$MCP_CONFIG" \
        "$@"
}

################################################################################
# 📖 Docs Architect - Technical Documentation, System Analysis
################################################################################
claude_docs() {
    local _prompt="$1"
    shift

    if [ -z "$_prompt" ]; then
        echo "📖 Docs Architect Agent"
        echo "Usage: claude_docs '<prompt>' [additional args]"
        echo ""
        echo "Examples:"
        echo "  claude_docs 'Document the system architecture'"
        echo "  claude_docs 'Create an architecture guide' --add-dir ./src"
        return 1
    fi

    claude "$_prompt" \
        --agents '[{"source":"./agents/docs-architect.md"}]' \
        --mcp-config "$MCP_CONFIG" \
        "$@"
}

################################################################################
# 📋 Utility Functions
################################################################################

# List all available specialized agents
claude_agents_list() {
    cat << 'EOF'
Available Specialized Agent Launchers:

🔍 claude_review <prompt>
   Expert code review specialist
   Focus: Quality, security, configuration analysis
   Model: Sonnet

🔴 claude_debug <prompt>
   Root cause analysis debugging specialist
   Focus: Structural problem solving, bug analysis
   Model: Sonnet

🏗️  claude_architect <prompt>
   Software architecture reviewer
   Focus: Design patterns, SOLID principles, system coherence
   Model: Opus

📚 claude_apidoc <prompt>
   API documentation specialist
   Focus: OpenAPI specs, SDKs, developer experience
   Model: Haiku

🎨 claude_frontend <prompt>
   Frontend developer specializing in React
   Focus: Components, responsive design, accessibility
   Model: Sonnet

📖 claude_docs <prompt>
   Technical documentation architect
   Focus: System documentation, architecture guides
   Model: Opus

Usage:
  source ./scripts/fn_claude_agents.sh
  <function_name> "<prompt>" [--add-dir DIR] [--session-id ID] ...

All functions support pass-through arguments to the claude command.
EOF
}

# Show help for all agents
claude_agents_help() {
    echo "🧠 Claude Specialized Agent Launcher Functions"
    echo ""
    echo "Quick Start:"
    echo "  source ./scripts/fn_claude_agents.sh"
    echo "  claude_review 'Review my code changes'"
    echo ""
    echo "For detailed list:"
    echo "  claude_agents_list"
    echo ""
    echo "For help on specific agent:"
    echo "  claude_review  (no args for help)"
    echo "  claude_debug   (no args for help)"
    echo "  etc..."
    echo ""
    echo "Features:"
    echo "  ✓ Specialized agent prompts with glyphs"
    echo "  ✓ Integrated MCP config support"
    echo "  ✓ Pass-through argument support"
    echo "  ✓ Session management compatibility"
    echo ""
}

################################################################################
# Export Functions
################################################################################

export -f claude_review
export -f claude_debug
export -f claude_architect
export -f claude_apidoc
export -f claude_frontend
export -f claude_docs
export -f claude_agents_list
export -f claude_agents_help

# Print notice on source
if [ "${BASH_SOURCE[0]}" = "${0}" ]; then
    echo "🧠 Specialized Agent Functions Loaded"
    echo "Run 'claude_agents_help' for usage information"
fi
