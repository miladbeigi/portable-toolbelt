# Portable Toolbelt 🛠️

A lightweight, cross-platform tool installer for quickly setting up essential development and system administration tools on Linux servers and containers. Perfect for DevOps engineers, system administrators, and developers who need to quickly provision tools on fresh systems.

## ✨ Features

- **Cross-platform support**: Works on Ubuntu, Debian, Pop!_OS, and Alpine Linux
- **Profile-based installation**: Pre-configured tool sets for different use cases
- **Individual tool selection**: Install specific tools as needed
- **One-liner installation**: Simple curl-based setup
- **Automatic OS detection**: No manual configuration required
- **Lightweight**: Minimal dependencies, just curl and bash

## 🚀 Quick Start

### Prerequisites
- `curl` (for installation)
- `bash` (for Alpine Linux)

### Installation

**Ubuntu/Debian/Pop!_OS:**
```bash
# Install curl if not present
sudo apt update && sudo apt install curl -y

# Install with default core profile
curl -sSL https://milad.cloud/toolbelt | bash -s

# Install specific tools
curl -sSL https://milad.cloud/toolbelt | bash -s -- --tools=vim,htop,jq

# Install with a profile
curl -sSL https://milad.cloud/toolbelt | bash -s -- --profile=dev
```

**Alpine Linux:**
```bash
# Install curl and bash if not present
apk update && apk add curl bash

# Install with default core profile
curl -sSL https://milad.cloud/toolbelt | bash -s

# Install specific tools
curl -sSL https://milad.cloud/toolbelt | bash -s -- --tools=vim,htop,jq

# Install with a profile
curl -sSL https://milad.cloud/toolbelt | bash -s -- --profile=dev
```

## 📦 Available Tools

| Tool | Description | Use Case |
|------|-------------|----------|
| `vim` | Text editor | File editing and configuration |
| `htop` | Process viewer | System monitoring |
| `screen` | Terminal multiplexer | Session management |
| `jq` | JSON processor | JSON data manipulation |
| `yq` | YAML processor | YAML data manipulation |
| `wget` | File downloader | File downloads |
| `nmap` | Network scanner | Network reconnaissance |
| `tcpdump` | Packet analyzer | Network debugging |
| `openssl` | SSL/TLS toolkit | Certificate management |
| `gpg` | Encryption tool | File encryption/signing |

## 🎯 Available Profiles

### Core Profile (`--profile=core`)
Essential tools for basic system administration:
- `vim` - Text editor
- `htop` - Process viewer

### Developer Profile (`--profile=dev`)
Tools for development and debugging:
- `vim` - Text editor
- `htop` - Process viewer
- `screen` - Terminal multiplexer
- `jq` - JSON processor
- `yq` - YAML processor

### Security Profile (`--profile=security`)
Tools for security analysis and network debugging:
- `nmap` - Network scanner
- `tcpdump` - Packet analyzer
- `openssl` - SSL/TLS toolkit
- `gpg` - Encryption tool

## 💡 Usage Examples

### Install a single tool
```bash
curl -sSL https://milad.cloud/toolbelt | bash -s -- --tools=vim
```

### Install multiple specific tools
```bash
curl -sSL https://milad.cloud/toolbelt | bash -s -- --tools=vim,htop,jq,yq
```

### Install with developer profile
```bash
curl -sSL https://milad.cloud/toolbelt | bash -s -- --profile=dev
```

### Install with security profile
```bash
curl -sSL https://milad.cloud/toolbelt | bash -s -- --profile=security
```

## 🔧 How It Works

1. **OS Detection**: Automatically detects your Linux distribution
2. **Package Manager Selection**: Uses the appropriate package manager (apt/apk)
3. **Tool Installation**: Installs tools using native package managers
4. **Profile Processing**: Loads tool lists from profile files
5. **Error Handling**: Provides clear error messages for unsupported systems

## 🏗️ Architecture

```
portable-toolbelt/
├── install.sh          # Main installer script
├── boot.sh            # Bootstrap script for remote installation
├── profiles/          # Pre-configured tool profiles
│   ├── core.txt       # Core tools
│   ├── dev.txt        # Developer tools
│   └── security.txt   # Security tools
├── src/
│   ├── core/          # Core utilities
│   │   └── detect_os.sh
│   └── tools/         # Individual tool installers
│       ├── vim.sh
│       ├── htop.sh
│       └── ...
└── configs/           # Configuration files (future use)
```

## 🤝 Contributing

Contributions are welcome! Here's how you can help:

1. **Add new tools**: Create install scripts in `src/tools/`
2. **Add new profiles**: Create profile files in `profiles/`
3. **Support new OS**: Extend OS detection in `src/core/detect_os.sh`
4. **Improve documentation**: Update README and add examples
5. **Report issues**: Open GitHub issues for bugs or feature requests

### Adding a New Tool

1. Create `src/tools/your-tool.sh`:
```bash
#!/usr/bin/env bash

set -e

install_your_tool() {
  case "$DISTRO_NAME" in
    ubuntu|debian|pop)
      $SUDO apt update -y
      $SUDO apt install -y your-tool
      ;;
    alpine)
      $SUDO apk update
      $SUDO apk add your-tool
      ;;
    *)
      echo "[ERROR] Your-tool install not supported on this distro: $DISTRO_NAME"
      exit 1
      ;;
  esac
}
```

2. Add the tool to appropriate profiles in `profiles/`

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Inspired by the need for quick tool provisioning on fresh servers
- Built with simplicity and portability in mind
- Thanks to the open-source community for the tools included

---

**Made with ❤️ for the DevOps community**
