# Integration Instructions

## Quick Integration

### Option 1: Manual Source (Immediate Use)
```bash
cd /a/src/palimpsest/mia-agents
source ./scripts/fn_copilot_agents.sh
```

### Option 2: Add to Shell RC (Persistent)
Add to your `~/.bashrc` or `~/.zshrc`:
```bash
# GitHub Copilot Agent Functions
if [ -f /a/src/palimpsest/mia-agents/scripts/fn_copilot_agents.sh ]; then
    source /a/src/palimpsest/mia-agents/scripts/fn_copilot_agents.sh
fi
```

### Option 3: Add to _env.sh (Project-Specific)
Add to `/a/src/palimpsest/mia-agents/_env.sh`:
```bash
# Load Copilot Agent Functions
if [ -f "./scripts/fn_copilot_agents.sh" ]; then
    source ./scripts/fn_copilot_agents.sh
fi
```

---

## Verification

After sourcing, verify with:
```bash
copilot_agents_list
type copilot_review
```

---

## Usage in Workflows

### Git Pre-Commit Hook
```bash
#!/bin/bash
# .git/hooks/pre-commit

cd /a/src/palimpsest/mia-agents
source ./scripts/fn_copilot_agents.sh

echo "Running code review..."
if ! copilot_review "Review staged changes"; then
    echo "Review found issues. Fix them or use --no-verify to skip."
    exit 1
fi
```

### Development Aliases
Add to your shell RC:
```bash
# Quick agent access
alias cpreview='copilot_review'
alias cpdebug='copilot_debug'
alias cparch='copilot_architect'
alias cptrouble='copilot_troubleshoot'
alias cpdocs='copilot_docs'
```

---

## Team Distribution

### Share with Team
```bash
# Team members can clone and source
git clone <repo>
cd mia-agents
source ./scripts/fn_copilot_agents.sh
```

### CI/CD Integration
```yaml
# .github/workflows/review.yml
name: Automated Review
on: [pull_request]
jobs:
  review:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Review Code
        run: |
          source ./scripts/fn_copilot_agents.sh
          copilot_review "Review PR changes"
```

---

## Troubleshooting

### Function Not Found
Make sure you're using `source` not execution:
```bash
# ✅ Correct
source ./scripts/fn_copilot_agents.sh

# ❌ Wrong
./scripts/fn_copilot_agents.sh
```

### Wrong Directory
Functions assume you're in project root:
```bash
cd /a/src/palimpsest/mia-agents
source ./scripts/fn_copilot_agents.sh
```

### Check if Loaded
```bash
type copilot_review
declare -F | grep copilot
```
