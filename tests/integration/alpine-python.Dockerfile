FROM alpine:latest

# Install dependencies  
RUN apk update && apk add curl bash git

# Copy the project files
COPY . /toolbelt
WORKDIR /toolbelt

# Make install script executable and run Python profile
RUN chmod +x install.sh && \
    ./install.sh --profile=python

# Test Python tools are available
RUN which python3 && \
    which pip && \
    which pytest && \
    which black && \
    python3 --version && \
    pip --version