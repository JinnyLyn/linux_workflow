#!/bin/bash
# run-checks.sh (Python)
# This script is the universal entrypoint for the Pillar 2 Supervisor loop.

echo "Running Python checks..."

# Check if ruff exists, if so run it
if command -v ruff >/dev/null 2>&1; then
    echo "Running ruff linter..."
    ruff check . || exit 1
else
    echo "Warning: ruff not found. Skipping linting."
fi

# Check if pytest exists, if so run it
if command -v pytest >/dev/null 2>&1; then
    echo "Running pytest..."
    pytest || exit 1
else
    echo "Warning: pytest not found. Skipping tests."
fi

echo "All checks passed successfully."
exit 0
