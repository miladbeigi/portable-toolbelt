FROM amazonlinux:2

ARG PROFILE=${PROFILE}

RUN yum update -y && yum install -y bash

# Copy the project files
COPY . /toolbelt
WORKDIR /toolbelt

# Make install script executable and run it
RUN chmod +x install.sh && \
    ./install.sh --profile=${PROFILE:-core} --yes
