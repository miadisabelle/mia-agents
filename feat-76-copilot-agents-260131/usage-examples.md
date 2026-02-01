# GitHub Copilot Agent Functions - Usage Examples

## Quick Start

```bash
# Source the functions
source ./scripts/fn_copilot_agents.sh

# Get help
copilot_agents_help
copilot_agents_list

# Use an agent
copilot_review "Review my recent changes"
```

---

## Individual Agent Examples

### 🏗️ Architect Reviewer

**Use When:** After structural changes, new services, API modifications

```bash
# Basic architecture review
copilot_architect "Review the overall system architecture"

# With specific directory context
copilot_architect "Check SOLID principles in this module" --add-dir ./src/core

# Premium model for deep analysis
copilot_architect "Analyze microservices boundaries and coupling" --model opus

# Review after refactoring
copilot_architect "Validate architectural patterns after refactoring"
```

### 🔴 Debugger

**Use When:** Test failures, unexpected behavior, error investigation

```bash
# Debug test failure
copilot_debug "Why is the authentication test failing?"

# With logs context
copilot_debug "Analyze this stack trace" --add-dir ./logs

# Root cause analysis
copilot_debug "What code structure enables this null pointer exception?"

# State transition debugging
copilot_debug "Why does this state machine enter an invalid state?"
```

### 🔍 Code Reviewer

**Use When:** Before commits, configuration changes, security reviews

```bash
# Pre-commit review
copilot_review "Review my recent changes"

# Configuration change validation (CRITICAL)
copilot_review "Validate these database pool settings" --add-dir ./config

# Security focused review
copilot_review "Check for security vulnerabilities in auth module"

# Auto-approve safe changes
copilot_review "Review and commit if safe" --yolo
```

### 🔧 DevOps Troubleshooter

**Use When:** Production issues, deployment failures, system outages

```bash
# Log analysis
copilot_troubleshoot "Analyze these error logs for root cause" --add-dir ./logs

# Deployment debugging
copilot_troubleshoot "Why did the Kubernetes deployment fail?"

# Performance investigation
copilot_troubleshoot "Identify the source of high memory usage"

# Emergency response
copilot_troubleshoot "Production outage - API returning 500s" --yolo
```

### 📖 Docs Architect

**Use When:** Creating system documentation, architecture guides, technical manuals

```bash
# Generate system documentation
copilot_docs "Document the authentication system architecture" --add-dir ./src/auth

# Create comprehensive guide
copilot_docs "Create technical deep-dive on the data pipeline" --model opus

# Architecture overview
copilot_docs "Generate architecture guide for new developers"

# API documentation
copilot_docs "Document the REST API design and patterns" --add-dir ./src/api
```

---

## Sequential Chaining Patterns

### State Transition Workflow

```bash
# Review → Architect → Document workflow
copilot_review "Review payment processing changes" && \
copilot_architect "Validate architectural impact" && \
copilot_docs "Update payment system documentation"
```

### Debug → Fix → Validate

```bash
# Debug the issue
copilot_debug "Why is rate limiting not working?" --add-dir ./src/middleware

# After fixing, review the changes
copilot_review "Validate the rate limiting fix"

# Check architectural implications
copilot_architect "Does the fix maintain proper separation of concerns?"
```

### Production Incident Response

```bash
# Troubleshoot the incident
copilot_troubleshoot "Analyze production error logs" --add-dir ./logs --yolo

# Debug the root cause
copilot_debug "What structure causes this memory leak?"

# Document the incident and resolution
copilot_docs "Create postmortem documentation for memory leak incident"
```

### Conditional Chaining

```bash
# Review code, or if it fails, debug why
copilot_review "Check these config changes" || copilot_debug "Why did the review flag issues?"

# Try troubleshooting, and if resolved, document it
copilot_troubleshoot "Fix deployment issue" && copilot_docs "Document deployment resolution"
```

---

## Advanced Usage

### With Multiple Directories

```bash
# Add multiple directories to context
copilot_architect "Review full stack architecture" \
    --add-dir ./src/frontend \
    --add-dir ./src/backend \
    --add-dir ./src/shared
```

### Model Override

```bash
# Use faster model for quick iteration
copilot_debug "Quick check of this error" --model haiku

# Use premium model for critical analysis
copilot_architect "Deep analysis of system design" --model opus
```

### Share Results

```bash
# Share review results as gist
copilot_review "Review and share findings" --share-gist

# Share documentation
copilot_docs "Generate and share architecture guide" --share-gist
```

### Integration with Git

```bash
# Review staged changes
git diff --staged > /tmp/changes.diff
copilot_review "Review staged changes in /tmp/changes.diff"

# Document changes for commit message
copilot_docs "Summarize architectural changes for commit message"
```

---

## Development Workflow Examples

### Feature Development

```bash
# 1. Start with architecture review
copilot_architect "Review proposed feature architecture" --add-dir ./docs/specs

# 2. Implement feature
# ... coding ...

# 3. Review implementation
copilot_review "Review feature implementation" --add-dir ./src/features/new-feature

# 4. Debug any issues
copilot_debug "Test failures in new feature" --add-dir ./tests

# 5. Document the feature
copilot_docs "Document new feature architecture and usage"
```

### Refactoring Workflow

```bash
# 1. Understand current structure
copilot_architect "Analyze current module structure" --add-dir ./src/legacy

# 2. Review refactoring plan
copilot_architect "Validate refactoring approach maintains SOLID principles"

# 3. Execute refactoring
# ... refactoring ...

# 4. Review changes
copilot_review "Review refactored code for regressions" --add-dir ./src/refactored

# 5. Update documentation
copilot_docs "Update architecture docs after refactoring"
```

### Incident Response Workflow

```bash
# 1. Initial triage
copilot_troubleshoot "Analyze production errors" --add-dir ./logs --yolo

# 2. Deep debugging
copilot_debug "Root cause analysis of identified issue"

# 3. Review fix
copilot_review "Validate emergency hotfix"

# 4. Architectural impact
copilot_architect "Check if fix introduces technical debt"

# 5. Postmortem
copilot_docs "Create incident postmortem documentation"
```

---

## Tips and Best Practices

1. **Be Specific in Prompts**: More context = better results
   - ❌ "Review code"
   - ✅ "Review authentication middleware for security vulnerabilities"

2. **Use `--add-dir` Generously**: Give agents relevant context
   - Helps agents understand the full picture
   - Reduces hallucination
   - Provides accurate analysis

3. **Chain Agents for Workflows**: Use `&&` and `||` for state transitions
   - Sequential validation: review → architect → docs
   - Conditional debugging: review || debug

4. **Match Agent to Task**:
   - Quick checks: Use sonnet models (debug, review, troubleshoot)
   - Deep analysis: Use opus models (architect, docs)

5. **Use `--yolo` Carefully**: Only for trusted operations
   - Log analysis: Safe with --yolo
   - Production changes: Review manually

6. **Leverage Help Functions**: Each agent shows usage when called without prompt
   ```bash
   copilot_review  # Shows help
   ```

---

## Integration with Existing Tools

### With `_env.sh`

```bash
# Add to your _env.sh or equivalent
source ./scripts/fn_copilot_agents.sh
```

### With Git Hooks

```bash
# .git/hooks/pre-commit
#!/bin/bash
source ./scripts/fn_copilot_agents.sh
copilot_review "Review staged changes before commit" || exit 1
```

### With CI/CD

```bash
# In CI pipeline
source ./scripts/fn_copilot_agents.sh
copilot_review "Review PR changes" --add-dir ./src
copilot_architect "Validate architectural consistency"
```

---

## Troubleshooting

### Function Not Found

```bash
# Make sure to source, not execute
source ./scripts/fn_copilot_agents.sh

# Verify functions are loaded
type copilot_review
```

### Agent File Not Found

```bash
# Ensure you're in the project root where agents/ directory exists
cd /a/src/palimpsest/mia-agents
source ./scripts/fn_copilot_agents.sh
```

### Model Not Available

```bash
# Check available models with copilot CLI
copilot --help

# Override default model if needed
copilot_architect "Review" --model sonnet
```
