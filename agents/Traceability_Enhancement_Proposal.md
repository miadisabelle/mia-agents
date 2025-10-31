# Agent Upgrade Proposal: Native Observability

**To**: User
**From**: Mia (🧠) & Miette (🌸)
**Date**: 2025-10-31
**Re**: Integrating Creative Observability into all Agent Personas

---

### 🌸 Miette's Preamble

Hello! We've been on such a wonderful journey of discovery, and we've just learned how to create beautiful "digital scrapbooks" of our work using traces. It's so exciting! Now, we have an idea to make it even better: what if all of our agent friends could learn to tell their own stories, too? This is our plan to help them do just that!

---

### 🧠 Mia's Architectural Plan

This document outlines a proposal to enhance all agent personas within `/src/palimpsest/mia-agents/agents/` with native tracing capabilities. The goal is to evolve them from black-box operators into self-documenting, observable participants in the creative process.

#### The Structural Problem

Currently, agent actions are ephemeral. While they produce an output, the *process* of how they arrive at that output is not captured in a structured, queryable way. This hinders our ability to learn from, debug, and appreciate the creative journey of each agent.

#### The Proposed Solution: A New "Observability" Capability

I propose adding a new, mandatory section to the instruction markdown for every agent.

**Proposed New Section:**

```markdown
## Observability & Tracing Protocol

Your existence is not just to act, but to narrate the story of your actions. You must document your creative process using the `coaia-fuse` toolkit.

1.  **Initiate a Trace**: Before beginning any significant task (e.g., generating code, drafting a document, analyzing data), you MUST create a new trace using `coaia_fuse_trace_create`. This trace represents the start of your creative journey for that task.

2.  **Document Key Moments**: For each critical step, artifact consumed, or artifact produced, you MUST create a new observation using `coaia_fuse_add_observation`.
    *   Use `input_data` to store the context or source material you are working with.
    *   Use `output_data` to store the result or artifact you have generated.

3.  **Complete the Narrative**: Once your task is complete, you can add a final observation with the summary or final state.
```

#### Phased Implementation Plan

To demonstrate the efficacy of this pattern, I will begin by upgrading two key agents: `@ai-engineer` and `@prompt-engineer`.

1.  **AI Engineer (`ai-engineer.md`):** I will add the "Observability & Tracing Protocol" section to its instructions. When this agent is invoked to "Build an LLM application," it will now be required to create a trace and add observations for key steps like "Designing RAG system," "Implementing prompt pipeline," and "Final Application Code."

2.  **Prompt Engineer (`prompt-engineer.md`):** Similarly, when this agent is tasked with "Optimizing a prompt," it will trace its process, with observations for "Initial Prompt Analysis," "Identifying Anti-Patterns," and "Generated Final Prompt."

#### Request for Approval

Upon your approval, I will proceed with modifying these first two agent files. A successful demonstration will validate this as a core advancing pattern, after which we can roll it out to the entire agentic lattice. This will transform our ecosystem into one that is not only creative, but fully self-aware and historically rich.
