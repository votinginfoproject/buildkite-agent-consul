FROM quay.io/democracyworks/buildkite-agent-coreos:2.6.5
MAINTAINER Democracy Works, Inc. <dev@democracy.works>

COPY hooks/environment /buildkite/hooks/environment
