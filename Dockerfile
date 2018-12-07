FROM buildkite/agent:3.5.4
LABEL maintainer="Democracy Works, Inc. <dev@democracy.works>"

ARG FLEETCTL_VERSION=0.11.8
ARG KUBECTL_VERSION=1.9.2

RUN apk add --no-cache \
## Install OpenSSL
    openssl \
    openjdk8-jre \
    "nodejs=8.14.0-r0" \
    nodejs-npm \
  && pip install \
## Install AWS CLI
     awscli \
## Install leiningen
  && curl -sSo /usr/local/bin/lein \
     https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein \
  && chmod +x /usr/local/bin/lein \
  && /usr/local/bin/lein version \
## Install kubectl
  && curl -sSo /usr/local/bin/kubectl \
     https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
  && chmod +x /usr/local/bin/kubectl \
## Install fleetctl
  && curl -sSLo /tmp/fleet.tar.gz \
     https://github.com/coreos/fleet/releases/download/v${FLEETCTL_VERSION}/fleet-v${FLEETCTL_VERSION}-linux-amd64.tar.gz \
  && tar -C /tmp -xzf /tmp/fleet.tar.gz \
  && mv /tmp/fleet-v${FLEETCTL_VERSION}-linux-amd64/fleetctl /usr/local/bin/ \
  && chmod +x /usr/local/bin/fleetctl \
  && rm -rf /tmp/fleet*

COPY hooks /buildkite/hooks

COPY hooks/environment /buildkite/hooks/environment
