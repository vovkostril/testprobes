FROM ubuntu:22.04
RUN apt-get update \
 && </dev/null DEBIAN_FRONTEND=noninteractive \
    apt-get --yes install  --no-install-recommends python3.9 nodejs \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
 