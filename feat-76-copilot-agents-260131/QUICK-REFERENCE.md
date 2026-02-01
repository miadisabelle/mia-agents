# GitHub Copilot Agent Functions - Quick Reference Card

## 🚀 One-Line Setup
```bash
source ./scripts/fn_copilot_agents.sh
```

## 🤖 Available Agents

| Glyph | Function | Model | Purpose |
|-------|----------|-------|---------|
| 🏗️ | `copilot_architect` | opus | Architecture review, SOLID principles |
| 🔴 | `copilot_debug` | sonnet | Root cause analysis, structural debugging |
| 🔍 | `copilot_review` | sonnet | Code quality, security, config validation |
| 🔧 | `copilot_troubleshoot` | sonnet | Production debugging, incident response |
| 📖 | `copilot_docs` | opus | Comprehensive technical documentation |

## 📖 Help Commands
```bash
copilot_agents_help          # Overview
copilot_agents_list          # Detailed list
copilot_<agent>              # Show agent-specific help (no args)
```

## 💡 Common Patterns

### Basic Usage
```bash
copilot_review "Review my changes"
copilot_debug "Why is this failing?"
copilot_architect "Check architecture" --add-dir ./src
```

### With Context
```bash
copilot_review "Check config" --add-dir ./config
copilot_troubleshoot "Analyze logs" --add-dir ./logs
copilot_docs "Document system" --add-dir ./src
```

### Sequential Chaining
```bash
# Success chain
copilot_review "Check" && copilot_architect "Validate"

# Fallback chain
copilot_review "Check" || copilot_debug "Why failed?"

# Full workflow
copilot_review "Check changes" && \
copilot_architect "Validate arch" && \
copilot_docs "Update docs"
```

## 🎛️ Common Flags

| Flag | Purpose | Example |
|------|---------|---------|
| `--add-dir <dir>` | Add context directory | `--add-dir ./src` |
| `--yolo` | Auto-approve actions | `--yolo` |
| `--model <model>` | Override default model | `--model opus` |
| `--share-gist` | Share as GitHub gist | `--share-gist` |

## 🔄 Workflow Templates

### Pre-Commit Check
```bash
copilot_review "Review staged changes" && \
copilot_architect "Check architectural impact"
```

### Debug Session
```bash
copilot_debug "Analyze test failure" --add-dir ./tests
copilot_review "Validate fix after debugging"
```

### Feature Complete
```bash
copilot_review "Review feature" --add-dir ./src/feature && \
copilot_architect "Validate design" && \
copilot_docs "Document feature"
```

### Incident Response
```bash
copilot_troubleshoot "Emergency analysis" --add-dir ./logs --yolo
copilot_debug "Root cause investigation"
copilot_docs "Create postmortem"
```

## 🎯 When to Use Each Agent

### 🏗️ copilot_architect
- After structural changes
- New service/API design
- Refactoring validation
- Design pattern review

### 🔴 copilot_debug
- Test failures
- Unexpected behavior
- Root cause analysis
- Logic error investigation

### 🔍 copilot_review
- Before commits
- Configuration changes (CRITICAL)
- Security reviews
- Code quality checks

### 🔧 copilot_troubleshoot
- Production issues
- Deployment failures
- Log analysis
- Performance problems

### 📖 copilot_docs
- Architecture guides
- System documentation
- Technical manuals
- API documentation

## ⚡ Pro Tips

1. **Be Specific**: More context = better results
2. **Use `--add-dir`**: Always provide relevant directories
3. **Chain for Workflows**: Use `&&` for sequential validation
4. **Match Model to Task**: opus for deep, sonnet for speed
5. **Check Help First**: Call without args to see usage

## 🐛 Troubleshooting

```bash
# Check if loaded
type copilot_review

# Reload if needed
source ./scripts/fn_copilot_agents.sh

# Ensure in project root
cd /a/src/palimpsest/mia-agents
```

## 📚 Full Documentation

- **Plan**: `feat-76-copilot-agents-260131/plan.md`
- **Examples**: `feat-76-copilot-agents-260131/usage-examples.md`
- **Summary**: `feat-76-copilot-agents-260131/SUMMARY.md`
- **Integration**: `feat-76-copilot-agents-260131/INTEGRATION.md`

---

**Remember**: Structure determines behavior. Easy access to expertise → Better development practices! ✨
