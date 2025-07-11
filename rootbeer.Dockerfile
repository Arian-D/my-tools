#!/usr/bin/env -S sh -c 'podman build -q -t $(basename "$0" .Dockerfile) -f "$0" . && podman run --rm --entrypoint bash -it $(basename "$0" .Dockerfile)'

FROM docker.io/jdxcode/mise
RUN git clone -b main https://github.com/tale/rootbeer /roobeer
WORKDIR /roobeer
RUN apt-get update && apt-get install -y cmake pkg-config libsolv-dev
RUN mise trust && mise install --yes
RUN meson setup --reconfigure build
RUN mise run build
