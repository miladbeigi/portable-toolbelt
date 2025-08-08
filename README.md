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
```

**Alpine Linux:**
```bash
# Install curl and bash if not present
apk update && apk add curl bash

# Install with default core profile
curl -sSL https://milad.cloud/toolbelt | bash -s
```

## 📦 Available Tools

### Core Tools
| Tool | Description | Use Case |
|------|-------------|----------|
| `vim` | Text editor | File editing and configuration |
| `htop` | Process viewer | System monitoring |
| `curl` | HTTP client | API calls and data transfer |
| `bash` | Shell | Scripting and automation |

### Development Tools
| Tool | Description | Use Case |
|------|-------------|----------|
| `screen` | Terminal multiplexer | Session management |
| `jq` | JSON processor | JSON data manipulation |
| `yq` | YAML processor | YAML data manipulation |
| `wget` | File downloader | File downloads |

### Network Troubleshooting Tools
| Tool | Description | Use Case |
|------|-------------|----------|
| `nmap` | Network scanner | Network reconnaissance |
| `tcpdump` | Packet analyzer | Network debugging |
| `net-tools` | Legacy networking | Interface and route management |
| `iproute2` | Modern networking | Advanced network configuration |
| `mtr` | Real-time traceroute | Route path analysis |
| `dig` | DNS lookup | DNS troubleshooting |
| `nslookup` | DNS query | Name resolution testing |
| `wireshark-cli` | Packet analysis | Deep packet inspection |
| `netcat` | Network connectivity | Port testing and data transfer |
| `telnet` | Basic connectivity | Service testing |
| `iperf3` | Bandwidth testing | Network performance measurement |
| `speedtest-cli` | Internet speed test | Connection speed verification |
| `iftop` | Real-time bandwidth | Network usage monitoring |
| `nethogs` | Per-process usage | Application network analysis |

### Security Tools
| Tool | Description | Use Case |
|------|-------------|----------|
| `openssl` | SSL/TLS toolkit | Certificate management |
| `gpg` | Encryption tool | File encryption/signing |

## 🎯 Available Profiles

### Core Profile (`--profile=core`)
Essential tools for basic system administration:
- `vim` - Text editor
- `htop` - Process viewer
- `curl` - HTTP client
- `bash` - Shell

### Developer Profile (`--profile=dev`)
Tools for development and debugging:
- `vim` - Text editor
- `htop` - Process viewer
- `screen` - Terminal multiplexer
- `jq` - JSON processor
- `yq` - YAML processor
- `curl` - HTTP client
- `bash` - Shell

### Network Profile (`--profile=network`)
Comprehensive network troubleshooting and diagnostics:
- **Core utilities**: net-tools, iproute2, curl, wget
- **Diagnostics**: nmap, tcpdump, ping, traceroute, mtr, dig, nslookup
- **Security**: openssl, wireshark-cli, netcat, telnet
- **Performance**: iperf3, speedtest-cli, iftop, nethogs

### Security Profile (`--profile=security`)
Tools for security analysis and network debugging:
- `nmap` - Network scanner
- `tcpdump` - Packet analyzer
- `openssl` - SSL/TLS toolkit
- `gpg` - Encryption tool

### All Tools Profile (`--profile=all`)
Complete toolset with all available tools (24 tools total):
- All core, development, network, and security tools

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

### Install with network profile
```bash
curl -sSL https://milad.cloud/toolbelt | bash -s -- --profile=network
```

### Install with all tools
```bash
curl -sSL https://milad.cloud/toolbelt | bash -s -- --profile=all
```



## 🔧 How It Works

1. **OS Detection**: Automatically detects your Linux distribution
2. **Package Manager Selection**: Uses the appropriate package manager (apt/apk)
3. **Tool Installation**: Installs tools using native package managers
4. **Profile Processing**: Loads tool lists from profile files

## 🏗️ Architecture

```
portable-toolbelt/
├── install.sh          # Main installer script
├── boot.sh            # Bootstrap script for remote installation
├── Makefile           # Convenient targets for testing
├── profiles/          # Pre-configured tool profiles
│   ├── core.txt       # Core tools (4 tools)
│   ├── dev.txt        # Developer tools (7 tools)
│   ├── network.txt    # Network troubleshooting (18 tools)
│   ├── security.txt   # Security tools (4 tools)
│   └── all.txt        # All tools (24 tools)
├── src/
│   ├── core/          # Core utilities
│   │   └── detect_os.sh
│   └── tools/         # Individual tool installers
│       ├── vim.sh
│       ├── htop.sh
│       ├── curl.sh
│       ├── bash.sh
│       └── ...        # 20+ tool installers
├── tests/             # Testing infrastructure
│   ├── integration/   # Docker integration tests
│   └── test-docker.sh # Docker testing script
└── configs/           # Configuration files (future use)
```

## 🧪 Testing

### Local Development Testing
```bash
# Test all Docker containers
make test

# Test specific distribution
make test-alpine
make test-ubuntu

# Clean up test images
make clean
```

### Manual Docker Testing
```bash
# Test Alpine Linux
docker build -f tests/integration/alpine.Dockerfile -t toolbelt-test:alpine .

# Test Ubuntu
docker build -f tests/integration/ubuntu.Dockerfile -t toolbelt-test:ubuntu .
```

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
