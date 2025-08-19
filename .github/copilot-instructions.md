# Portable Toolbelt

Portable Toolbelt is a lightweight, cross-platform tool installer for quickly setting up essential development and system administration tools on Linux servers and containers. The project consists of shell scripts that automatically detect the OS and install tools using native package managers (apt for Ubuntu/Debian, apk for Alpine).

**ALWAYS reference these instructions first and fallback to search or bash commands only when you encounter unexpected information that does not match the info here.**

## Working Effectively

### Bootstrap and Test the Repository:
- Clone and navigate to repository: `git clone <repo> && cd portable-toolbelt`
- Test core functionality: `sudo ./install.sh --profile=core` -- takes 2-8 seconds. NEVER CANCEL.
- Test individual tool: `sudo ./install.sh --tools=jq` -- takes 1-3 seconds. NEVER CANCEL.
- Test Docker integration: `make test-ubuntu` -- takes 10 seconds to 2 minutes. NEVER CANCEL. Set timeout to 5+ minutes.
- Test Alpine integration: `make test-alpine` -- takes 30 seconds to 2 minutes. NEVER CANCEL. Set timeout to 5+ minutes.
- Test all containers: `make test` -- takes 1-4 minutes total. NEVER CANCEL. Set timeout to 10+ minutes.

### Dependencies and Requirements:
- **Operating System**: Ubuntu, Debian, Pop!_OS, or Alpine Linux
- **Required Tools**: `curl`, `bash` (for Alpine), `sudo` privileges for package installation
- **For Testing**: Docker (for integration tests)

### Build Process:
- **No compilation required** - this is a pure shell script project
- Scripts are immediately executable after making changes
- **No linting tools** - manually review shell scripts for syntax

## Validation

### Essential Validation Scenarios:
Always run these scenarios after making changes to ensure functionality:

1. **Core Profile Validation**:
   ```bash
   sudo ./install.sh --profile=core
   vim --version && htop --version && curl --version && bash --version
   ```

2. **Individual Tool Validation**:
   ```bash
   sudo ./install.sh --tools=jq
   echo '{"test": "data"}' | jq '.test'
   ```

3. **Profile Loading Validation**:
   ```bash
   sudo ./install.sh --profile=dev
   screen -version && jq --version && yq --version
   ```

4. **Multiple Tool Installation**:
   ```bash
   sudo ./install.sh --tools=wget,screen
   wget --version && screen -version
   ```

5. **OS Detection Validation**:
   ```bash
   source src/core/detect_os.sh && detect_os && echo "Detected: $DISTRO_NAME"
   ```

### Docker Integration Testing:
- Always test both Ubuntu and Alpine: `make test-ubuntu && make test-alpine`
- Test timing: Ubuntu builds take 10-120 seconds, Alpine builds take 30-120 seconds

### Manual Validation Requirements:
- **ALWAYS** verify that installed tools actually execute and show correct versions
- **ALWAYS** test realistic scenarios: install a profile, then use tools for their intended purpose
- **ALWAYS** test both Ubuntu and Alpine pathways when modifying tool installers

## Common Tasks

### Repository Structure:
```
portable-toolbelt/
├── install.sh          # Main installer script
├── boot.sh            # Bootstrap script for remote installation  
├── Makefile           # Test automation targets
├── profiles/          # Pre-configured tool profiles
│   ├── core.txt       # Core tools (4 tools): vim, htop, curl, bash
│   ├── dev.txt        # Developer tools (7 tools)
│   ├── network.txt    # Network troubleshooting (18 tools)
│   ├── security.txt   # Security tools (4 tools)
│   └── all.txt        # All tools (23 tools)
├── src/
│   ├── core/          # Core utilities
│   │   └── detect_os.sh # OS detection logic
│   └── tools/         # Individual tool installers (23 scripts)
├── tests/             # Testing infrastructure
│   ├── integration/   # Docker integration tests
│   │   ├── alpine.Dockerfile
│   │   └── ubuntu.Dockerfile
│   └── test-docker.sh # Docker testing script
└── .github/
    └── workflows/
        └── tests.yml  # CI/CD pipeline
```

### Tool Installer Structure:
Each tool in `src/tools/*.sh` follows this pattern:
```bash
#!/usr/bin/env bash
set -e

install_TOOLNAME() {
  case "$DISTRO_NAME" in
    ubuntu|debian|pop)
      $SUDO apt update -y
      $SUDO apt install -y PACKAGE_NAME
      ;;
    alpine)
      $SUDO apk update
      $SUDO apk add PACKAGE_NAME
      ;;
    *)
      echo "[ERROR] TOOL install not supported on distro: $DISTRO_NAME"
      exit 1
      ;;
  esac
}
```

### Adding New Tools:
1. Create `src/tools/newtool.sh` following the pattern above
2. Add tool name to appropriate profile files in `profiles/`
3. Test installation: `sudo ./install.sh --tools=newtool`
4. Verify tool works: `newtool --version` or equivalent
5. Test in Docker: `make test-ubuntu test-alpine`

### Troubleshooting Common Issues:

#### Installation Failures:
- **Permission denied**: Use `sudo ./install.sh` (not `./install.sh`)
- **Package not found**: Check if tool name matches package name in Ubuntu/Alpine repos

#### CI/CD Pipeline:
- Uses GitHub Actions matrix strategy to test Ubuntu and Alpine
- Builds Docker containers and runs `./install.sh --profile=all`
- **Expected runtime**: 2-5 minutes per container build

### Development Workflow:
1. Make changes to scripts in `src/tools/` or profiles
2. Test locally: `sudo ./install.sh --tools=CHANGED_TOOL`
3. Validate tool works: run tool with `--version` or test command
4. Test both platforms: `make test-ubuntu test-alpine` (expect network failures)
5. Commit changes and push
6. Monitor CI pipeline for any unexpected failures

### Testing Multiple Tools:
```bash
# Test multiple specific tools
sudo ./install.sh --tools=vim,htop,jq
vim --version && htop --version && jq --version

# Test that profile files are correctly formatted
wc -l profiles/core.txt  # should show 3 (4 tools, no trailing newline)
wc -l profiles/all.txt   # should show 23 (all tools)
```

### Remote Installation Testing:
The repository supports remote installation via:
```bash
curl -sSL https://milad.cloud/toolbelt | bash -s -- --profile=core
```

This downloads and runs `boot.sh` which:
1. Detects OS and installs dependencies (curl, git, bash)
2. Clones the repository to `~/.local/share/portable-toolbelt`
3. Executes `install.sh` with provided arguments

### Alternative Local Testing of boot.sh:
```bash
# Test bootstrap components locally
chmod +x boot.sh
# Note: boot.sh requires network access to clone from GitHub
```

## Critical Timing and Timeout Guidelines:

- **Local tool installation**: 1-8 seconds per profile - Set timeout to 30+ seconds
- **Docker builds**: 30 seconds to 2 minutes - Set timeout to 5+ minutes  
- **Full test suite**: 1-4 minutes - Set timeout to 10+ minutes
- **NEVER CANCEL** any build or test command - Package downloads can be slow
- **Network dependencies**: All operations depend on package repository access
