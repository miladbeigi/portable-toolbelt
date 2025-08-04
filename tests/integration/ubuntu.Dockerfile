FROM ubuntu:latest

RUN apt update && apt install -y curl git && \
    curl -sSL https://milad.cloud/toolbelt | bash -s -- --profile=all
