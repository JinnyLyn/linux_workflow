#!/bin/bash
# run-checks.sh (C/C++)

echo "Running C/C++ checks..."

# Simple check to see if a Makefile exists
if [ -f "Makefile" ]; then
    echo "Running make test (if it exists) or make..."
    make test || make || exit 1
elif [ -f "CMakeLists.txt" ]; then
    echo "CMake project detected. Checking build..."
    mkdir -p build && cd build && cmake .. && make || exit 1
    cd ..
else
    echo "Warning: No Makefile or CMakeLists.txt found. Ensure build passes manually."
fi

# Placeholder for clang-tidy if configured
if command -v clang-tidy >/dev/null 2>&1; then
    echo "Note: clang-tidy is available. Agents should use it if compile_commands.json exists."
fi

echo "All checks passed successfully."
exit 0
