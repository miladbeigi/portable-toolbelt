.PHONY: test test-docker test-apk test-apt test-dnf test-yum test-amazonlinux2 test-amazonlinux2023 help

# Default target
help:
	@echo "Available targets:"
	@echo "  test-docker          - Run all Docker tests (Alpine + Ubuntu + Redhat + Amazon Linux)"
	@echo "  test-apk             - Test Alpine Linux container only"
	@echo "  test-apt             - Test Ubuntu container only"
	@echo "  test-dnf             - Test Fedora Linux container using dnf"
	@echo "  test-yum             - Test Oracle Linux container using yum"
	@echo "  test-amazonlinux2    - Test Amazon Linux 2 container"
	@echo "  test-amazonlinux2023 - Test Amazon Linux 2023 container"
	@echo "  help                 - Show this help message"

# Test all Docker containers
test-docker: test-apk test-apt test-dnf test-amazonlinux2 test-amazonlinux2023
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

# Test Amazon Linux 2
test-amazonlinux2:
	@echo "🐧 Testing Amazon Linux 2 container..."
	docker build --build-arg PROFILE=$(PROFILE) -f tests/integration/amazonlinux2.Dockerfile -t toolbelt-test:amazonlinux2 .
	@echo "✅ Amazon Linux 2 test passed!"

# Test Amazon Linux 2023
test-amazonlinux2023:
	@echo "🐧 Testing Amazon Linux 2023 container..."
	docker build --build-arg PROFILE=$(PROFILE) -f tests/integration/amazonlinux2023.Dockerfile -t toolbelt-test:amazonlinux2023 .
	@echo "✅ Amazon Linux 2023 test passed!"

# Alias for test-docker
test: test-docker

