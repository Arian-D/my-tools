FROM docker.io/oven/bun:debian
RUN apt-get -qq update && apt-get -qq --yes install wget git
RUN wget https://github.com/helix-editor/helix/releases/download/25.07.1/helix_25.7.1-1_amd64.deb && apt-get install ./helix_25.7.1-1_amd64.deb
ENV EDITOR=hx
WORKDIR /amp-dir
# Note: I'm not sure of the legality of including amp's package in the image, so it'll be lazyloaded
ENTRYPOINT bunx @sourcegraph/amp@latest
