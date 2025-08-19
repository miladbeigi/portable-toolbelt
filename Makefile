.PHONY: test test-docker test-alpine test-ubuntu test-python test-alpine-python test-ubuntu-python clean clean-docker help

# Default target
help:
	@echo "Available targets:"
	@echo "  test-docker        - Run all Docker tests (Alpine + Ubuntu)"
	@echo "  test-python        - Run Python profile tests (Alpine + Ubuntu)"
	@echo "  test-alpine        - Test Alpine Linux container only"
	@echo "  test-ubuntu        - Test Ubuntu container only"
	@echo "  test-alpine-python - Test Python profile on Alpine only"
	@echo "  test-ubuntu-python - Test Python profile on Ubuntu only"
	@echo "  clean-docker       - Remove test Docker images"
	@echo "  help               - Show this help message"

# Test all Docker containers
test-docker: test-alpine test-ubuntu
	@echo "✅ All Docker tests completed!"

# Test Python profile on both platforms
test-python: test-alpine-python test-ubuntu-python
	@echo "✅ All Python profile tests completed!"

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

# Test Alpine Python profile
test-alpine-python:
	@echo "🐍 Testing Alpine Linux with Python profile..."
	docker build -f tests/integration/alpine-python.Dockerfile -t toolbelt-test:alpine-python .
	@echo "✅ Alpine Python test passed!"

# Test Ubuntu Python profile
test-ubuntu-python:
	@echo "🐍 Testing Ubuntu with Python profile..."
	docker build -f tests/integration/ubuntu-python.Dockerfile -t toolbelt-test:ubuntu-python .
	@echo "✅ Ubuntu Python test passed!"

# Clean up Docker test images
clean-docker:
	@echo "🧹 Cleaning up Docker test images..."
	docker rmi toolbelt-test:alpine toolbelt-test:ubuntu toolbelt-test:alpine-python toolbelt-test:ubuntu-python 2>/dev/null || true
	@echo "✅ Cleanup completed!"

# Alias for test-docker
test: test-docker

# Alias for clean-docker
clean: clean-docker
