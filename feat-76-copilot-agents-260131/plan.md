# Plan: Copilot Agent Launcher Functions (feat-76)

**Status:** ✅ Complete (Revised for cost efficiency)

## Design Principle

**Cheap by default.** Use `gpt-5-mini` for simple automatable tasks that can run in pipelines. Reserve expensive models for truly complex work.

## Implemented Functions

### 📋 Cheap Tasks (gpt-5-mini, --yolo enabled)
| Function | Purpose |
|----------|---------|
| `copilot_index <dir>` | Index files with summaries |
| `copilot_summarize <target>` | Summarize file/dir in bullets |
| `copilot_commit_msg` | Generate commit message |
| `copilot_lint [target]` | Quick lint check |
| `copilot_todos [target]` | Extract TODO/FIXME comments |
| `copilot_diff_summary` | Summarize git changes |

### �� Standard Tasks (sonnet)
| Function | Purpose |
|----------|---------|
| `copilot_review` | Code review |
| `copilot_debug` | Debug assistance |
| `copilot_troubleshoot` | DevOps troubleshooting |

### 🏗️ Premium Tasks (opus - warns before use)
| Function | Purpose |
|----------|---------|
| `copilot_architect` | Architecture review |
| `copilot_docs` | Documentation generation |

## Usage

```bash
source ./scripts/fn_copilot_agents.sh

# Cheap pipeline tasks
copilot_index logs/
copilot_commit_msg
copilot_todos ./src

# Override to even cheaper
COPILOT_CHEAP_MODEL=haiku copilot_summarize README.md
```

## Files
- `scripts/fn_copilot_agents.sh` - The function library (213 lines)
- `feat-76-copilot-agents-260131/plan.md` - This file
- `feat-76-copilot-agents-260131/input-message.md` - Original request
