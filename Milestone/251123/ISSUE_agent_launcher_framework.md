# Agent Launcher Framework - Directional Issue

**Date:** 2025-11-23
**Status:** Foundation Complete - Ready for Integration

## What We Built

Created a simple launcher system for specialized agents. Six functions now launch Claude with pre-configured agent personalities:

- `claude_review` - Code reviews
- `claude_debug` - Bug investigation
- `claude_architect` - Architecture analysis
- `claude_apidoc` - API documentation
- `claude_frontend` - Frontend work
- `claude_docs` - System documentation

Each agent is visually identified with a glyph (🔍 🔴 🏗️ 📚 🎨 📖).

## Files Created

- `scripts/fn_claude_agents.sh` - The launcher functions (249 lines)
- `scripts/AGENT_LAUNCHERS.md` - Usage documentation
- Updated 7 agent files with glyph formatting

## Where This Goes

### Next: Integration & Usage
- Team starts using these functions in daily workflows
- Identify which agents get used most
- Find what's missing or needs adjustment

### Then: Expansion
- Add more agents as needed (backend, data, etc.)
- Create agent combinations for complex tasks
- Build templates for common workflows

### Later: Observation & Refinement
- Track which agent+task combinations work well
- Improve agent prompts based on real usage
- Document patterns that emerge

## Success Looks Like

Someone sources the script and runs:
```bash
claude_review "look at this code"
```

It works. They don't think about it. Just use it.

## Not Doing (Yet)

- Complex agent orchestration
- AI routing between agents
- Advanced session management
- Fancy UI

Keep it simple. Get feedback first.

## Open Questions

- Which agents will people actually use daily?
- Should we add 2-3 more specialized agents?
- Does the glyph formatting help or distract?
- Where should these live for easy access?

## Notes

This is foundation work. The real value comes when people use it and tell us what they need.

Start simple. Iterate based on actual usage patterns.
