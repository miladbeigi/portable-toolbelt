# Portable Toolbelt 🛠️

A lightweight, cross-platform tool installer for quickly setting up essential development and system administration tools on Linux servers and containers. Perfect for DevOps engineers, system administrators, and developers who need to quickly provision tools on fresh systems.

## ✨ Features

- **Cross-platform support**: Works on Ubuntu, Debian, Pop!_OS, Alpine Linux, RHEL family (CentOS, RHEL, Fedora, Rocky Linux, AlmaLinux), and Amazon Linux (AL2, AL2023)
- **Profile-based installation**: Pre-configured tool sets for different use cases
- **Individual tool selection**: Install specific tools as needed
- **One-liner installation**: Simple curl-based setup
- **Automatic OS detection**: No manual configuration required
- **Lightweight**: Minimal dependencies, just curl, bash, and git

## 🚀 Quick Start

### Prerequisites
- `curl` (for installation)
- `bash` (for Alpine Linux)
- `git` (automatically installed by boot.sh if not present)

### Installation

**Ubuntu/Debian/Pop!_OS:**
```bash
# Install curl if not present
sudo apt update && sudo apt install curl -y

# Install with default core profile
curl -sSL https://milad.cloud/toolbelt | bash -s
```

**RHEL Family (CentOS, RHEL, Fedora, Rocky Linux, AlmaLinux):**
```bash
# Install curl if not present
sudo dnf install curl -y
# or for older systems: sudo yum install curl -y

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

**Amazon Linux 2 / AL2023:**
```bash
# Install curl if not present
sudo yum install curl -y
# or for AL2023: sudo dnf install curl -y

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

### Python Development Tools
| Tool | Description | Use Case |
|------|-------------|----------|
| `python3` | Python interpreter | Running Python scripts and applications |
| `pytest` | Testing framework | Python unit and integration testing |

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

### Python Profile (`--profile=python`)
Python development tools and packages:
- `python3` - Python interpreter with venv support
- `pytest` - Testing framework

### All Tools Profile (`--profile=all`)
Complete toolset with all available tools:
- All core, development, network, security, and Python tools

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

### Install with Python development profile
```bash
curl -sSL https://milad.cloud/toolbelt | bash -s -- --profile=python
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

1. **OS Detection**: Automatically detects your Linux distribution (Ubuntu/Debian/Pop!_OS, Alpine, RHEL family, Amazon Linux)
2. **Package Manager Selection**: Uses the appropriate package manager (apt/apk/dnf/yum) based on the `DISTRO_FAMILY` variable
3. **Tool Installation**: Installs tools using native package managers with distribution-specific package names, using the `PACKAGE_MANAGER` variable
4. **Profile Processing**: Loads tool lists from profile files

## 🏗️ Architecture

```
portable-toolbelt/
├── install.sh          # Main installer script
├── boot.sh            # Bootstrap script for remote installation
├── Makefile           # Convenient targets for testing
├── profiles/          # Pre-configured tool profiles
│   ├── core.txt       # Core tools
│   ├── dev.txt        # Developer tools
│   ├── network.txt    # Network troubleshooting
│   ├── security.txt   # Security tools
│   ├── python.txt     # Python development tools
│   └── all.txt        # All tools
├── src/
│   ├── core/          # Core utilities
│   │   ├── detect_os.sh
│   │   └── set_sudo.sh
│   └── tools/         # Individual tool installers
│       ├── vim.sh
│       ├── htop.sh
│       ├── curl.sh
│       ├── bash.sh
│       └── ...        # other tool installers
└── tests/             # Testing infrastructure
    └── integration/   # Docker integration tests
```

## 🧪 Testing

### Local Development Testing
```bash
# Test all Docker containers
make test
# or
make test-docker

# Test specific distribution
make test-apk      # Alpine Linux
make test-apt      # Ubuntu/Debian
make test-dnf      # Fedora/RHEL (dnf)
make test-yum      # Oracle Linux (yum)
```

### Manual Docker Testing
```bash
# Test Alpine Linux
docker build -f tests/integration/alpine.Dockerfile -t toolbelt-test:alpine .

# Test Ubuntu
docker build -f tests/integration/ubuntu.Dockerfile -t toolbelt-test:ubuntu .

# Test Redhat/Fedora
docker build -f tests/integration/redhat.Dockerfile -t toolbelt-test:redhat .
```

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
