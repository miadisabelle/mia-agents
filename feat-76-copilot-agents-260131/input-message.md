# Feature Request: Copilot Agent Launcher Functions

**Date:** 2026-02-01T02:32:42.150Z

**Context Files:**
- `scripts/copilot_update_logs_INDEX.sh` - Sample CLI usage patterns
- `scripts/fn_claude_agents.sh` - Existing Claude agent launcher functions
- `agents/` - Directory containing 83 specialized agent definitions

## Request

Analyze which of these agents we could abstract into a new set of functions like `scripts/fn_copilot_agents.sh` to make them do simple tasks in the filesystem with adequate arguments and full prompting included in the CLI so we can launch them and use them also in some sequence, to transition between states while we develop software.

## Objectives

1. Create `scripts/fn_copilot_agents.sh` modeled after `fn_claude_agents.sh`
2. Identify the top 5 most important agents from the 83 available
3. Implement launcher functions for these agents
4. Enable sequential agent chaining for state transitions during development
5. Include full prompting and adequate argument passing

## Deliverables

1. Analysis of existing agents to identify top candidates
2. New `scripts/fn_copilot_agents.sh` function library
3. Working launcher functions for the top 5 agents
4. Documentation and usage examples
5. Plan for future agent integration
