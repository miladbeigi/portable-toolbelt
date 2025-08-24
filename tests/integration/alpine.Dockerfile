FROM alpine:latest

ARG PROFILE=${PROFILE}

RUN apk update && apk add bash

# Copy the project files
COPY . /toolbelt
WORKDIR /toolbelt

# Make install script executable and run it
RUN chmod +x install.sh && \
    ./install.sh --profile=${PROFILE:-core}
