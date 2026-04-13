# OPENCODE.md (Python Rules)

## Core Directives
1. **Pillar 1 (The Map):** This file contains absolute project rules. If you (the agent) make an error caught by tests/linters, you MUST add a concise, 1-sentence rule here to prevent future recurrence.
2. **Pillar 2 (Supervisor Loop):** Do not finalize work without ensuring `./run-checks.sh` passes completely.
3. **Pillar 3 (Garbage Collection):** Code must be clean. No commented-out dead code.

## Language Specifics (Python)
- Always use Python 3.
- Rely on `pytest` for testing.
- Rely on `ruff` for linting and formatting.
- Ensure proper type hinting (`typing`) is used where applicable.

## Dynamic Constraints (Added by Agents)
- (Agents: Append new rules below this line when mistakes occur)
