---
status: completed
phase: 2
updated: 2026-04-16
---

# Implementation Plan

## Goal
Update the Harness framework to enforce strict autonomous subagent/skill usage and fully activate the persistent Caveman communication mode globally.

## Context & Decisions
| Decision | Rationale | Source |
|----------|-----------|--------|
| Retain empty `.opencode/` folders | Empty folders enable local overrides while keeping the project clean and falling back to global defaults. | `bin/oc-init` script analysis |
| Reinforce primary agent prompts | Current instructions ("Use them proactively") are too soft. Imperative constraints are needed to guarantee subagent invocation. | `agents/build.md`, `AGENTS.md` |
| Inject Caveman rules into AGENTS.md | Merely stating "caveman is active" without the rules fails. The core rules of `caveman/SKILL.md` must be copied into `AGENTS.md` so the LLM has the exact syntax rules without needing to explicitly call the skill tool. | `skills/caveman/SKILL.md` |

## Phase 1: Caveman & Documentation [COMPLETED]
- [x] **1.1 Integrate Caveman Rules**
      Extract the core syntax rules from `skills/caveman/SKILL.md` and append them directly into `AGENTS.md` so all agents inherit the speaking style by default.
- [x] 1.2 Update framework README/docs to explicitly state that local `.opencode/` directories are intentionally empty for future project-specific overrides.

## Phase 2: Agent Autonomy Enforcement [COMPLETED]
- [x] 2.1 Update `AGENTS.md` with strict penalties/directives for failing to delegate to subagents like `@error-checker` or `@scribe`.
- [x] 2.2 Update `agents/build.md` with explicit tool call examples for autonomously invoking MCPs and the `skill` tool.
- [x] 2.3 Update `agents/plan.md` to strictly require using the `skill` tool to load domain-specific experts before drafting architecture.

## Notes
- 2026-04-16: Investigated `oc-init` script which confirms intentional creation of empty directories via `mkdir -p`.
- 2026-04-16: `caveman` skill requires the LLM to know its specific constraints (e.g., dropping articles, Fragments OK) which are missing from the global `AGENTS.md` context. Proceeding with Phase 1 approach (embedding rules directly into AGENTS.md).
