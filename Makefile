.PHONY: test test-docker test-apk test-apt test-dnf test-yum help

# Default target
help:
	@echo "Available targets:"
	@echo "  test-docker     - Run all Docker tests (Alpine + Ubuntu + Redhat)"
	@echo "  test-apk        - Test Alpine Linux container only"
	@echo "  test-apt        - Test Ubuntu container only"
	@echo "  test-dnf        - Test Fedora Linux container using dnf"
	@echo "  test-yum        - Test Oracle Linux container using yum"
	@echo "  help            - Show this help message"

# Test all Docker containers
test-docker: test-apk test-apt test-dnf test-yum
	@echo "✅ All Docker tests completed!"

# Test Alpine Linux
test-apk:
	@echo "🐧 Testing Alpine Linux container..."
	docker build --build-arg PROFILE=$(PROFILE)  -f tests/integration/alpine.Dockerfile -t toolbelt-test:alpine .
	@echo "✅ Alpine Linux test passed!"

# Test Ubuntu
test-apt:
	@echo "🐧 Testing Ubuntu container..."
	docker build --build-arg PROFILE=$(PROFILE) -f tests/integration/ubuntu.Dockerfile -t toolbelt-test:ubuntu .
	@echo "✅ Ubuntu test passed!"

test-dnf:
	@echo "🐧 Testing Redhat Linux container..."
	docker build --build-arg PROFILE=$(PROFILE) -f tests/integration/redhat.Dockerfile -t toolbelt-test:redhat .
	@echo "✅ Redhat Linux test passed!"

# Alias for test-docker
test: test-docker

