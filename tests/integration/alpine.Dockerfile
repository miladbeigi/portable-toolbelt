FROM alpine:latest

RUN apk update && apk add curl bash && \
    curl -sSL https://milad.cloud/toolbelt | bash -s -- --profile=all
