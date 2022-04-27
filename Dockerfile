FROM ubuntu:jammy

LABEL maintainer="devops@true-tickets.com"

ARG SIGIL_VERSION=0.8.1
# Set these as ARG so they are only available during build
ARG DEBIAN_FRONTEND=noninteractive
ARG RUNTIME_DEPS="bash ca-certificates curl unzip"

RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends $RUNTIME_DEPS; \
    curl -sLO https://github.com/gliderlabs/sigil/releases/download/v${SIGIL_VERSION}/gliderlabs-sigil_${SIGIL_VERSION}_linux_amd64.tgz; \
    tar xvf gliderlabs-sigil_${SIGIL_VERSION}_linux_amd64.tgz; mv gliderlabs-sigil-amd64 /usr/local/bin/sigil; \
    find /usr/share/man \
         /usr/share/doc \
         /var/lib/apt/lists \
         /var/log \
         /var/tmp \
         /tmp \
         -type f -exec rm -f {} +

ENTRYPOINT ["/usr/local/bin/sigil"]
