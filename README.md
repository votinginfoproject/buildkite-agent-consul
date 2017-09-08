# buildkite-agent-consul

Project to build/run the buildkite agents on fleet managed coreos servers, pulling
configuration primarily via consul.

## Build & Deploy

### Prerequisites

A coreos environment with a configured consul kv store, and you have your
FLEETCTL_TUNNEL or FLEETCTL_ENDPOINT setup to talk to the cluster. Always a good
idea to run `fleetctl list-units` and verify it's the correct environment. It's
important to note that we deploy all the agents to the staging environment,
regardless of whether they are then building and deploying for staging or
production. This is why there are two templates, one for staging and one for
production.

### Build

Run `./script/build <environment>`, i.e. `./script/build staging`. Environments
can be either `staging` or `production`.
At the end, it will tell you what `docker push` command you should run to push
the agent container up to quay.io.

### Deploy

Run `./script/deploy <environment>`, using the same environment you used for the
build.

## Configuration

The `buildkite-agent-consul-<environment>@.service.template` file can give you
an idea of what configuration values need to be in consul, more can be found
about the specifics in internal documentation.

## BK Pipelines

### Build Env Vars

No specific env vars need to be set other than those needed by the project's
build script. Often this will be quay.io login and password.

### Deploy Env Vars

In addition to any project specific deploy env vars, you need to set up a
`FLEETCTL_TUNNEL=<ip.address.node.in.cluster>`. This needs to point to the
IP address of one of the nodes in the target cluster (staging or production).
