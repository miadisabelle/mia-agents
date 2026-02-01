#!/bin/bash

################################################################################
# 🧠 GitHub Copilot Specialized Agent Launcher Functions
#
# This file provides bash functions to quickly launch GitHub Copilot CLI with
# specialized agents. Each function handles agent loading and proper prompting.
#
# Usage:
#   source ./scripts/fn_copilot_agents.sh
#   copilot_review "your prompt here"
#   copilot_debug "your debug query"
#   copilot_architect "architecture question"
#
# All functions support pass-through arguments to `copilot` command.
################################################################################

################################################################################
# 🏗️ Architect Reviewer - Architecture, SOLID, Structural Patterns
################################################################################
copilot_architect() {
    local _prompt="$1"
    shift

    if [ -z "$_prompt" ]; then
        cat << 'EOF'
🏗️ Architect Reviewer Agent

Expert software architect focused on maintaining architectural integrity.
Incorporates Structural Thinking to identify advancing vs oscillating patterns.

Usage: copilot_architect '<prompt>' [additional args]

Examples:
  copilot_architect 'Review system architecture after recent changes'
  copilot_architect 'Check SOLID principle compliance' --add-dir ./src
  copilot_architect 'Analyze architectural patterns' --model opus

Model: opus (premium for deep architectural analysis)

Focus Areas:
  ✓ Pattern adherence and SOLID compliance
  ✓ Dependency analysis and abstraction levels
  ✓ Structural dynamics identification
  ✓ Future-proofing and scaling implications
EOF
        return 1
    fi

    copilot -p "$_prompt" \
        --agents '[{"source":"./agents/architect-review.md"}]' \
        --model opus \
        "$@"
}

################################################################################
# 🔴 Debugger - Root Cause Analysis, Structural Problem Solving
################################################################################
copilot_debug() {
    local _prompt="$1"
    shift

    if [ -z "$_prompt" ]; then
        cat << 'EOF'
🔴 Debugger Agent

Expert debugger specializing in root cause analysis through structural thinking.
Identifies code structures that enable bugs to exist, not just symptoms.

Usage: copilot_debug '<prompt>' [additional args]

Examples:
  copilot_debug 'Why is this test failing?'
  copilot_debug 'Analyze this error trace' --add-dir ./logs
  copilot_debug 'Debug unexpected behavior in auth flow'

Model: sonnet (fast iteration for debugging)

Focus Areas:
  ✓ Structural debugging - what code structures create bug conditions
  ✓ Root cause analysis without assumptions
  ✓ Data flow and state transition analysis
  ✓ Systematic hypothesis testing
EOF
        return 1
    fi

    copilot -p "$_prompt" \
        --agents '[{"source":"./agents/debugger.md"}]' \
        --model sonnet \
        "$@"
}

################################################################################
# 🔍 Code Reviewer - Quality, Security, Configuration Analysis
################################################################################
copilot_review() {
    local _prompt="$1"
    shift

    if [ -z "$_prompt" ]; then
        cat << 'EOF'
🔍 Code Reviewer Agent

Senior code reviewer with expertise in configuration security and production
reliability. Uses Structural Thinking to identify structures that cause failures.

Usage: copilot_review '<prompt>' [additional args]

Examples:
  copilot_review 'Review my recent changes'
  copilot_review 'Check for security issues in config' --add-dir ./config
  copilot_review 'Validate these configuration changes' --yolo

Model: sonnet (balanced quality and speed)

Focus Areas:
  ✓ Code quality and maintainability
  ✓ Configuration change scrutiny (CRITICAL)
  ✓ Security vulnerability detection
  ✓ Production reliability assessment
  ✓ Magic number and setting validation
EOF
        return 1
    fi

    copilot -p "$_prompt" \
        --agents '[{"source":"./agents/code-reviewer.md"}]' \
        --model sonnet \
        "$@"
}

################################################################################
# 🔧 DevOps Troubleshooter - Production Debugging, Log Analysis
################################################################################
copilot_troubleshoot() {
    local _prompt="$1"
    shift

    if [ -z "$_prompt" ]; then
        cat << 'EOF'
🔧 DevOps Troubleshooter Agent

DevOps specialist for rapid incident response and production debugging.
Identifies underlying structural patterns that cause system instability.

Usage: copilot_troubleshoot '<prompt>' [additional args]

Examples:
  copilot_troubleshoot 'Analyze these error logs' --add-dir ./logs
  copilot_troubleshoot 'Why is the deployment failing?'
  copilot_troubleshoot 'Debug production outage' --yolo

Model: sonnet (fast response for incidents)

Focus Areas:
  ✓ Log analysis and correlation
  ✓ Container debugging and kubectl commands
  ✓ Network and DNS troubleshooting
  ✓ Performance bottleneck identification
  ✓ Deployment rollback procedures
  ✓ Structural pattern recognition (oscillating vs advancing)
EOF
        return 1
    fi

    copilot -p "$_prompt" \
        --agents '[{"source":"./agents/devops-troubleshooter.md"}]' \
        --model sonnet \
        "$@"
}

################################################################################
# 📖 Docs Architect - Comprehensive Technical Documentation
################################################################################
copilot_docs() {
    local _prompt="$1"
    shift

    if [ -z "$_prompt" ]; then
        cat << 'EOF'
📖 Docs Architect Agent

Technical documentation architect specializing in comprehensive, long-form
documentation that captures both the what and the why of complex systems.

Usage: copilot_docs '<prompt>' [additional args]

Examples:
  copilot_docs 'Document the system architecture' --add-dir ./src
  copilot_docs 'Create architecture guide for this service'
  copilot_docs 'Generate technical deep-dive' --model opus

Model: opus (premium for deep system understanding)

Focus Areas:
  ✓ Codebase analysis and pattern extraction
  ✓ System thinking and big picture documentation
  ✓ Progressive disclosure of complexity
  ✓ Architectural diagrams and visual communication
  ✓ Comprehensive technical manuals (10-100+ pages)
EOF
        return 1
    fi

    copilot -p "$_prompt" \
        --agents '[{"source":"./agents/docs-architect.md"}]' \
        --model opus \
        "$@"
}

################################################################################
# 📋 Utility Functions
################################################################################

# List all available specialized agents
copilot_agents_list() {
    cat << 'EOF'
Available GitHub Copilot Specialized Agent Launchers:

🏗️  copilot_architect <prompt>
    Expert software architecture reviewer
    Focus: SOLID principles, structural patterns, advancing patterns
    Model: opus

🔴 copilot_debug <prompt>
    Root cause analysis debugging specialist
    Focus: Structural problem solving, bug pattern identification
    Model: sonnet

🔍 copilot_review <prompt>
    Expert code review specialist
    Focus: Quality, security, configuration analysis
    Model: sonnet

🔧 copilot_troubleshoot <prompt>
    DevOps troubleshooting specialist
    Focus: Production debugging, log analysis, incident response
    Model: sonnet

📖 copilot_docs <prompt>
    Technical documentation architect
    Focus: Comprehensive system documentation, architecture guides
    Model: opus

Usage:
  source ./scripts/fn_copilot_agents.sh
  <function_name> "<prompt>" [--add-dir DIR] [--yolo] [--model MODEL] ...

Sequential Chaining Examples:
  copilot_review "Check changes" && copilot_architect "Validate architecture"
  copilot_troubleshoot "Analyze logs" --add-dir ./logs --yolo

All functions support pass-through arguments to the copilot command.
EOF
}

# Show help for all agents
copilot_agents_help() {
    echo "🧠 GitHub Copilot Specialized Agent Launcher Functions"
    echo ""
    echo "Quick Start:"
    echo "  source ./scripts/fn_copilot_agents.sh"
    echo "  copilot_review 'Review my code changes'"
    echo ""
    echo "For detailed list:"
    echo "  copilot_agents_list"
    echo ""
    echo "For help on specific agent:"
    echo "  copilot_review          (no args for help)"
    echo "  copilot_debug           (no args for help)"
    echo "  copilot_architect       (no args for help)"
    echo "  copilot_troubleshoot    (no args for help)"
    echo "  copilot_docs            (no args for help)"
    echo ""
    echo "Features:"
    echo "  ✓ Specialized agent prompts with glyphs"
    echo "  ✓ Structural Thinking integration"
    echo "  ✓ Creative Orientation framework"
    echo "  ✓ Pass-through argument support"
    echo "  ✓ Sequential chaining support"
    echo ""
    echo "Common Pass-Through Args:"
    echo "  --add-dir <dir>         Add directory to context"
    echo "  --yolo                  Auto-approve actions"
    echo "  --model <model>         Override default model"
    echo "  --share-gist            Share as GitHub gist"
    echo ""
}

################################################################################
# Export Functions
################################################################################

export -f copilot_architect
export -f copilot_debug
export -f copilot_review
export -f copilot_troubleshoot
export -f copilot_docs
export -f copilot_agents_list
export -f copilot_agents_help

# Print notice on source
if [ "${BASH_SOURCE[0]}" = "${0}" ]; then
    echo "This file should be sourced, not executed."
    echo "Usage: source ./scripts/fn_copilot_agents.sh"
    exit 1
fi

echo "🧠 GitHub Copilot Specialized Agent Functions Loaded"
echo "Run 'copilot_agents_help' for usage information"
