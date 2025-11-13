#!/usr/bin/env -S sh -c 'podman build -q -t $(basename "$0" .Dockerfile) -f "$0" . && podman run --rm -v $(pwd):/amp-dir -e TERM -e AMP_API_KEY -it $(basename "$0" .Dockerfile)'

FROM docker.io/node:25

# Helix installation
RUN apt-get -qq update && apt-get -qq --yes install wget git
RUN wget --quiet https://github.com/helix-editor/helix/releases/download/25.07.1/helix_25.7.1-1_amd64.deb && apt-get install ./helix_25.7.1-1_amd64.deb

# Feel free to swap this out for an ne🤮vim or other inferior editors
ENV EDITOR=hx

# Mount this
WORKDIR /amp-dir

# Note: I'm not sure of the legality of including amp's package in the image, so it'll be lazyloaded
ENTRYPOINT npx -y @sourcegraph/amp@latest
