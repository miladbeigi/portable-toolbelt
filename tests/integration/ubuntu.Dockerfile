FROM ubuntu:latest

# Install dependencies
RUN apt update && apt install -y curl git

# Copy the project files
COPY . /toolbelt
WORKDIR /toolbelt

# Make install script executable and run it
RUN chmod +x install.sh && \
    ./install.sh --profile=all
