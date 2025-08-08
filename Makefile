.PHONY: test test-docker test-alpine test-ubuntu clean clean-docker help

# Default target
help:
	@echo "Available targets:"
	@echo "  test-docker    - Run all Docker tests (Alpine + Ubuntu)"
	@echo "  test-alpine    - Test Alpine Linux container only"
	@echo "  test-ubuntu    - Test Ubuntu container only"
	@echo "  clean-docker   - Remove test Docker images"
	@echo "  help          - Show this help message"

# Test all Docker containers
test-docker: test-alpine test-ubuntu
	@echo "✅ All Docker tests completed!"

# Test Alpine Linux
test-alpine:
	@echo "🐧 Testing Alpine Linux container..."
	docker build -f tests/integration/alpine.Dockerfile -t toolbelt-test:alpine .
	@echo "✅ Alpine Linux test passed!"

# Test Ubuntu
test-ubuntu:
	@echo "🐧 Testing Ubuntu container..."
	docker build -f tests/integration/ubuntu.Dockerfile -t toolbelt-test:ubuntu .
	@echo "✅ Ubuntu test passed!"

# Clean up Docker test images
clean-docker:
	@echo "🧹 Cleaning up Docker test images..."
	docker rmi toolbelt-test:alpine toolbelt-test:ubuntu 2>/dev/null || true
	@echo "✅ Cleanup completed!"

# Alias for test-docker
test: test-docker

# Alias for clean-docker
clean: clean-docker
