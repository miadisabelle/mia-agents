# 🧠 Agent Launcher Functions Guide

## Overview

The `fn_claude_agents.sh` script provides specialized bash functions to launch Claude with pre-configured agents. Each function is optimized for a specific role and includes visual glyph formatting for enhanced clarity.

## Quick Start

```bash
# Source the functions
source ./scripts/fn_claude_agents.sh

# Use an agent
claude_review "Review my recent git changes"
claude_debug "Why is this test failing?"
claude_architect "Analyze the system architecture"
```

## Available Agents

### 🔍 Code Reviewer
**Function:** `claude_review <prompt>`

Expert code review specialist with focus on security and configuration reliability.

**Strengths:**
- Configuration change analysis
- Security vulnerability detection
- Production reliability assessment
- Structural thinking about code impact

**Use When:**
- You've written or modified code
- You need security review
- Configuration changes made
- Before deployment

**Example:**
```bash
claude_review "Review my database migration script"
claude_review "Check this config change for risks" --add-dir ./config
```

---

### 🔴 Debugger
**Function:** `claude_debug <prompt>`

Root cause analysis specialist using structural thinking for bug resolution.

**Strengths:**
- Identifying code structures enabling bugs
- Understanding failure conditions
- Preventing recurrence
- Structural problem diagnosis

**Use When:**
- Encountering errors or exceptions
- Tests are failing
- Behavior is unexpected
- Need to understand why something breaks

**Example:**
```bash
claude_debug "Why does this API endpoint return 500?"
claude_debug "The test suite is failing with this error" --add-dir ./tests
```

---

### 🏗️ Architect Reviewer
**Function:** `claude_architect <prompt>`

Software architecture specialist focused on SOLID principles and design patterns.

**Strengths:**
- Architectural consistency
- Design pattern enforcement
- SOLID principle compliance
- Creative intent extraction
- Structural dynamics analysis

**Use When:**
- Making structural changes
- Adding new services
- Modifying APIs
- Reviewing major refactoring
- Assessing long-term implications

**Example:**
```bash
claude_architect "Review this new microservice architecture"
claude_architect "Check for circular dependencies" --add-dir ./src
```

---

### 📚 API Documenter
**Function:** `claude_apidoc <prompt>`

API documentation specialist with OpenAPI expertise and developer experience focus.

**Strengths:**
- OpenAPI 3.0 specification generation
- SDK documentation
- Interactive documentation
- Versioning strategies
- Developer onboarding

**Use When:**
- Creating or updating APIs
- Need OpenAPI specs
- Generating SDK documentation
- Writing API guides
- Creating Postman collections

**Example:**
```bash
claude_apidoc "Generate OpenAPI spec for our REST API"
claude_apidoc "Create SDK documentation" --add-dir ./src/api
```

---

### 🎨 Frontend Developer
**Function:** `claude_frontend <prompt>`

Frontend specialist with React expertise, responsive design, and accessibility focus.

**Strengths:**
- React component architecture
- Responsive CSS design
- Accessibility (WCAG) compliance
- Performance optimization
- State management patterns

**Use When:**
- Building React components
- Implementing responsive layouts
- Fixing frontend issues
- Improving accessibility
- Optimizing performance

**Example:**
```bash
claude_frontend "Build a reusable modal component"
claude_frontend "Fix the accessibility issues in our form" --add-dir ./components
```

---

### 📖 Docs Architect
**Function:** `claude_docs <prompt>`

Technical documentation specialist creating comprehensive system documentation.

**Strengths:**
- System architecture documentation
- Comprehensive technical manuals
- Design decision documentation
- Visual architecture diagrams
- Progressive complexity disclosure

**Use When:**
- Need system documentation
- Creating architecture guides
- Technical deep-dives required
- Onboarding documentation
- System analysis needed

**Example:**
```bash
claude_docs "Document the microservices architecture"
claude_docs "Create a comprehensive system guide" --add-dir ./src
```

---

## Advanced Usage

### Pass-Through Arguments

All functions support additional arguments that pass through to the `claude` command:

```bash
# Add directories for context
claude_review "Review my changes" --add-dir ./src --add-dir ./tests

# Use a specific session
claude_debug "Debug this issue" --session-id my_debug_session

# Combine multiple arguments
claude_architect "Analyze architecture" \
  --add-dir ./services \
  --add-dir ./lib \
  --session-id architecture_review
```

### Integration with Session Management

Functions work seamlessly with the existing session management system:

```bash
# Create a new session for architectural review
newsessionuuid architecture \
  --prompt "Review system design" \
  --mcp /src/.mcp.coaiapy.env.aetherial.json

# Source the session environment
source _env.sh

# Use agent with session
claude_architect "Detailed architecture review" --session-id $session_id_architecture
```

### Custom MCP Configuration

Override default MCP config:

```bash
export MCP_CONFIG="/path/to/custom/mcp.json"
claude_review "Code review with custom tools"
```

## Integration Patterns

### 1. Code Review Workflow

```bash
# Source agents
source ./scripts/fn_claude_agents.sh

# Review recent changes
claude_review "Review all recent changes"

# If issues found, debug them
claude_debug "Understand why this is happening"

# Check architecture impact
claude_architect "Will this break anything?"
```

### 2. Development Workflow

```bash
# Start frontend development
claude_frontend "Create a new dashboard page"

# Document the component
claude_docs "Document the new dashboard system"

# Create API docs
claude_apidoc "Generate API docs for new endpoints"
```

### 3. Debugging Workflow

```bash
# Initial debugging
claude_debug "Why is this test failing?"

# Code review of fix
claude_review "Review my bugfix"

# Architecture check
claude_architect "Does this fix introduce any issues?"
```

## Features

### ✅ Visual Glyphs
Each agent uses distinctive emojis for immediate visual identification:
- 🔍 Code Reviewer
- 🔴 Debugger
- 🏗️ Architect Reviewer
- 📚 API Documenter
- 🎨 Frontend Developer
- 📖 Docs Architect

### ✅ Specialized Prompts
Each agent contains detailed instructions optimized for their role with supporting glyphs throughout the documentation.

### ✅ MCP Integration
All functions are pre-configured to use the MCP server for enhanced capabilities.

### ✅ Flexibility
Functions accept pass-through arguments, allowing customization without modifying the base scripts.

### ✅ Session Management
Compatible with existing session creation and management system.

## Utility Functions

### List Available Agents
```bash
claude_agents_list
```

Displays all available agent launchers with descriptions and use cases.

### Get Help
```bash
claude_agents_help
```

Shows quick start guide and available commands.

### Get Agent Help
```bash
claude_review  # with no arguments shows usage
claude_debug   # with no arguments shows usage
```

## Configuration

### Environment Variables

| Variable | Default | Purpose |
|----------|---------|---------|
| `MCP_CONFIG` | `/src/.mcp.coaiapy.env.aetherial.json` | Path to MCP configuration |
| `SESSION_ROOT_DIR` | `/src/_sessiondata` | Root directory for sessions |
| `SESSION_ID_PREFIX` | `session_id_` | Prefix for session identifiers |

### Setting Custom Config

```bash
# In .bashrc or .env file
export MCP_CONFIG="/path/to/custom/mcp.json"

# Or temporarily for a command
MCP_CONFIG="/tmp/mcp.json" claude_review "Review code"
```

## Troubleshooting

### Functions Not Found
Ensure you've sourced the script:
```bash
source ./scripts/fn_claude_agents.sh
```

### MCP Config Not Found
Check that the default MCP config exists or set a custom path:
```bash
ls -la /src/.mcp.coaiapy.env.aetherial.json
export MCP_CONFIG="/path/to/mcp.json"
```

### Session Issues
Ensure session directories are writable:
```bash
ls -la /src/_sessiondata
chmod 755 /src/_sessiondata
```

## Best Practices

1. **Pick the Right Agent** - Use agents specialized for your task type
2. **Provide Context** - Use `--add-dir` to give agents relevant code context
3. **Chain Agents** - Use multiple agents in sequence for comprehensive analysis
4. **Session Management** - Use sessions for complex, multi-step work
5. **Review Results** - Always review agent output before applying changes

## Examples by Task Type

### Security Review
```bash
claude_review "Audit this code for security issues" --add-dir ./src/security
```

### Performance Optimization
```bash
claude_frontend "Optimize this component for performance" --add-dir ./components/heavy
```

### System Redesign
```bash
claude_architect "Design a scalable architecture for this system"
claude_docs "Document the new architecture"
```

### Bug Investigation
```bash
claude_debug "Why does this only fail in production?"
claude_review "Review the fix I implemented"
```

### Documentation Needs
```bash
claude_docs "Create comprehensive API documentation" --add-dir ./src/api
claude_apidoc "Generate OpenAPI specification"
```

## See Also

- [fn_llm.sh](./scripts/fn_llm.sh) - Session management and LLM functions
- [Agent Definitions](./agents/) - Individual agent specifications
- [MCP Configuration](../rispecs/iaip-holistic-reasoning-mcp.spec.md) - MCP server details

---

**Version:** 1.0
**Last Updated:** 2025-11-22
**Maintainer:** Mia & Team
