#!/usr/bin/env -S sh -c 'export name=$(basename "$0" .Dockerfile); podman build -qt $name -f "$0" . && podman run -q --rm -it $name $@'

FROM python:3.12
COPY --from=ghcr.io/astral-sh/uv:latest /uv /bin/uv
RUN uv pip install --system --no-cache crawl4ai
RUN crawl4ai-setup
ENTRYPOINT ["crwl", "crawl"]
CMD ["-h"]
