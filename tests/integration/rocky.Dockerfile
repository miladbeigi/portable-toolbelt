FROM rockylinux:9

# Install dependencies (using dnf on Rocky Linux 9)
RUN dnf update -y && dnf install -y curl git

# Copy the project files
COPY . /toolbelt
WORKDIR /toolbelt

# Make install script executable and run it
RUN chmod +x install.sh && \
    ./install.sh --profile=core