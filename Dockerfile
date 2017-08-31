FROM buildkite/agent:alpine-docker-1.11
MAINTAINER Democracy Works, Inc. <dev@democracy.works>

ENV FLEETCTL_VERSION 0.11.8

# install openssl, jq and aws
RUN pip install awscli
RUN apk add --update --no-cache openssl jq

# install fleetctl
ADD https://github.com/coreos/fleet/releases/download/v${FLEETCTL_VERSION}/fleet-v${FLEETCTL_VERSION}-linux-amd64.tar.gz /tmp/fleet.tar.gz
RUN tar -C /tmp -xzf /tmp/fleet.tar.gz && mv /tmp/fleet-v${FLEETCTL_VERSION}-linux-amd64/fleetctl /bin/ && \
    rm -rf /tmp/fleet-v${FLEETCTL_VERSION}-linux-amd64 && rm /tmp/fleet.tar.gz

COPY hooks /buildkite/hooks
