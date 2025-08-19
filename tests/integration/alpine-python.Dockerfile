FROM alpine:latest

# Install dependencies  
RUN apk update && apk add curl bash git

# Copy the project files
COPY . /toolbelt
WORKDIR /toolbelt

# Make install script executable and run core Python tools
RUN chmod +x install.sh && \
    ./install.sh --tools=python3,pipx

# Test basic Python tools are available
RUN which python3 && \
    which pipx && \
    python3 --version && \
    pipx --version