# Portable Toolbelt

A collection of portable scripts for quickly setting up essential tools on servers.

### Running on ubuntu/debian distributions

Make sure you have curl installed.

```bash
sudo apt update && sudo apt install curl -y
```

Then run the installer.

```bash
curl -sSL https://milad.cloud/toolbelt | bash -s -- --tools=vim
```

### Running on alpine linux

Before running the installer, you need to install curl and bash.

```bash
apk update && apk add curl bash
```

Then run the installer.

```bash
curl -sSL https://milad.cloud/toolbelt | bash -s -- --tools=vim
```