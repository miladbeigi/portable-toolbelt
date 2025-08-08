FROM alpine:latest

# Install dependencies
RUN apk update && apk add curl bash git

# Copy the project files
COPY . /toolbelt
WORKDIR /toolbelt

# Make install script executable and run it
RUN chmod +x install.sh && \
    ./install.sh --profile=all
