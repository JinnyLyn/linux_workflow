#!/bin/bash
# run-checks.sh (Go)

echo "Running Go checks..."

echo "Running go fmt..."
if [ -n "$(go fmt ./...)" ]; then
    echo "Files need formatting. Please run go fmt."
    exit 1
fi

echo "Running go vet..."
go vet ./... || exit 1

if command -v staticcheck >/dev/null 2>&1; then
    echo "Running staticcheck..."
    staticcheck ./... || exit 1
fi

echo "Running go test..."
go test ./... || exit 1

echo "All checks passed successfully."
exit 0
