#!/usr/bin/env bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if Docker is available
if ! command -v docker &> /dev/null; then
    print_error "Docker is not installed or not in PATH"
    exit 1
fi

# Get the project root directory
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$PROJECT_ROOT"

print_status "Testing toolbelt installation in Docker containers..."

# Test Alpine Linux
print_status "Building and testing Alpine Linux container..."
docker build -f tests/integration/alpine.Dockerfile -t toolbelt-test:alpine .
if [ $? -eq 0 ]; then
    print_status "Alpine Linux test passed!"
else
    print_error "Alpine Linux test failed!"
    exit 1
fi

# Test Ubuntu
print_status "Building and testing Ubuntu container..."
docker build -f tests/integration/ubuntu.Dockerfile -t toolbelt-test:ubuntu .
if [ $? -eq 0 ]; then
    print_status "Ubuntu test passed!"
else
    print_error "Ubuntu test failed!"
    exit 1
fi

print_status "All Docker tests completed successfully!"

# Optional: Clean up test images
read -p "Do you want to clean up test images? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    print_status "Cleaning up test images..."
    docker rmi toolbelt-test:alpine toolbelt-test:ubuntu 2>/dev/null || true
    print_status "Cleanup completed!"
fi
