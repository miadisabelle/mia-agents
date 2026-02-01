# Plan: Copilot Agent Launcher Functions (feat-76)

**Feature:** `scripts/fn_copilot_agents.sh` - GitHub Copilot CLI agent launcher functions  
**Date:** 2026-02-01  
**Status:** In Progress

---

## 🎯 Problem Statement

We have 83 specialized agent definitions in `agents/` but no convenient way to launch them via GitHub Copilot CLI with proper prompting and argument passing. The existing `fn_claude_agents.sh` demonstrates a successful pattern that we need to adapt for Copilot CLI.

## 🧠 Analysis: Top 5 Critical Agents

Based on analysis of agent capabilities and their integration with our Structural Thinking and Creative Orientation frameworks, the top 5 agents for initial implementation are:

### 1. 🏗️ **architect-review** (Model: opus)
**Why Critical:** Ensures architectural integrity and SOLID principles. Incorporates Structural Thinking to identify advancing vs oscillating patterns. Essential for maintaining system coherence.

**Use Cases:**
- Post-structural changes review
- New service/API architecture validation
- Pattern adherence verification

### 2. 🔴 **debugger** (Model: sonnet)
**Why Critical:** Structural debugging approach that identifies root structures causing bugs, not just symptoms. Fast model for rapid iteration.

**Use Cases:**
- Root cause analysis
- Test failure investigation
- Unexpected behavior diagnosis

### 3. 🔍 **code-reviewer** (Model: sonnet)
**Why Critical:** Proactive quality gate with special focus on configuration security and production reliability. Uses Structural Thinking for configuration review.

**Use Cases:**
- Pre-commit reviews
- Configuration change validation
- Security vulnerability detection

### 4. 🔧 **devops-troubleshooter** (Model: sonnet)
**Why Critical:** Rapid incident response with structural pattern identification. Essential for production systems.

**Use Cases:**
- Production debugging
- Log analysis
- System outage investigation
- Deployment issue resolution

### 5. 📖 **docs-architect** (Model: opus)
**Why Critical:** Creates comprehensive documentation from codebases. Uses premium model for deep system understanding.

**Use Cases:**
- System documentation generation
- Architecture guide creation
- Technical deep-dives

### Honorable Mentions (Future Expansion)
- **error-detective**: Log analysis specialist
- **legacy-modernizer**: RISE Framework integration for safe refactoring
- **prompt-engineer**: For AI feature development
- **test-automator**: Test suite generation

---

## 📋 Workplan

### Phase 1: Foundation ✅
- [x] Create feature directory `feat-76-copilot-agents-260131/`
- [x] Save input message
- [x] Analyze existing agents and `fn_claude_agents.sh` structure
- [x] Identify top 5 agents
- [x] Create initial `scripts/fn_copilot_agents.sh` skeleton

### Phase 2: Core Implementation ✅
- [x] Implement `copilot_architect()` function
- [x] Implement `copilot_debug()` function
- [x] Implement `copilot_review()` function
- [x] Implement `copilot_troubleshoot()` function
- [x] Implement `copilot_docs()` function

### Phase 3: Utilities ✅
- [x] Create `copilot_agents_list()` helper
- [x] Create `copilot_agents_help()` helper
- [x] Add export statements for all functions
- [x] Add source notification

### Phase 4: Testing & Documentation ✅
- [x] Test sourcing functions
- [x] Test list and help functions
- [x] Test individual function help display
- [x] Create comprehensive usage examples document
- [x] Document sequential chaining patterns

### Phase 5: Integration ✅
- [x] Create integration documentation (INTEGRATION.md)
- [x] Create commit with purposeful message (47a9972)
- [ ] Optional: Update main `_env.sh` to auto-source (user preference)
- [ ] Optional: Update CHANGELOG.md with new capability

---

## 🎨 Design Decisions

### CLI Pattern
Following the Copilot CLI patterns observed in `copilot_update_logs_INDEX.sh`:
```bash
copilot -p "<prompt with context>" \
    --agents '[{"source":"./agents/<agent>.md"}]' \
    --model <model> \
    [additional args]
```

### Function Signature
```bash
copilot_<agent_name>() {
    local _prompt="$1"
    shift
    
    if [ -z "$_prompt" ]; then
        # Show usage help
        return 1
    fi
    
    copilot -p "$_prompt" \
        --agents '[{"source":"./agents/<agent-file>.md"}]' \
        --model <model> \
        "$@"  # Pass through additional args
}
```

### Key Features
1. **Full prompt in CLI**: No hidden prompting - transparent and auditable
2. **Model specification**: Explicit model choice per agent
3. **Pass-through args**: Support for `--add-dir`, `--yolo`, `--share-gist`, etc.
4. **Help on empty call**: Each function shows usage when called without prompt
5. **Emoji glyphs**: Visual identification matching agent personalities

---

## 🔄 Sequential Chaining Pattern

Enable state transitions during development:
```bash
# Example workflow
copilot_review "Review recent changes" && \
copilot_architect "Check architectural impact" && \
copilot_docs "Update system documentation"

# Or with conditionals
copilot_review "Check this config" || copilot_troubleshoot "Why did review fail?"
```

---

## 📝 Notes

- The Copilot CLI uses `-p` flag for prompt (not positional like Claude)
- Agent files are in `./agents/` relative to project root
- Models: `opus` (premium), `sonnet` (standard), `haiku` (fast)
- All agents integrate Structural Thinking and Creative Orientation principles
- Functions should be idempotent and stateless

---

## 🚀 Future Enhancements

1. Add remaining agents (error-detective, legacy-modernizer, test-automator, etc.)
2. Create meta-function that routes to appropriate agent based on context
3. Add session management integration
4. Create agent pipelines for common workflows
5. Integrate with existing MCP configuration if applicable
