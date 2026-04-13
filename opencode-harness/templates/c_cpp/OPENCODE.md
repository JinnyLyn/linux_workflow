# OPENCODE.md (C/C++ Rules)

## Core Directives
1. **Pillar 1 (The Map):** This file contains absolute project rules. If you (the agent) make an error caught by tests/linters, you MUST add a concise, 1-sentence rule here to prevent future recurrence.
2. **Pillar 2 (Supervisor Loop):** Do not finalize work without ensuring `./run-checks.sh` passes completely.
3. **Pillar 3 (Garbage Collection):** Code must be clean. No commented-out dead code.

## Language Specifics (C/C++)
- Ensure memory management is strict (avoid leaks).
- Adhere to the established build system (`CMake` or `Make`).
- Check for compiler warnings; treat them as errors if possible.

## Dynamic Constraints (Added by Agents)
- (Agents: Append new rules below this line when mistakes occur)
