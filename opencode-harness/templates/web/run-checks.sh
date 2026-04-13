#!/bin/bash
# run-checks.sh (Web/Node)

echo "Running Web/Node checks..."

if [ -f "package.json" ]; then
    # Check for lint script
    if grep -q '"lint"' package.json; then
        echo "Running npm run lint..."
        npm run lint || exit 1
    fi

    # Check for test script
    if grep -q '"test"' package.json; then
        # Check if test script is just the default placeholder
        if ! grep -q '"echo \\"Error: no test specified\\""' package.json; then
             echo "Running npm run test..."
             npm run test || exit 1
        fi
    fi
else
    echo "Warning: No package.json found. Skipping npm checks."
fi

echo "All checks passed successfully."
exit 0
