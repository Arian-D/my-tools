#!/usr/bin/env -S sh -c 'podman run --rm -i $(basename "$0" .Dockerfile)'

# To use this, run `echo something | ./kokoro.Dockerfile | mpv -`

FROM ghcr.io/astral-sh/uv:debian

RUN git clone https://github.com/nazdridoy/kokoro-tts.git /kokoro-tts

WORKDIR /kokoro-tts

RUN uv venv
RUN uv sync

RUN wget https://github.com/nazdridoy/kokoro-tts/releases/download/v1.0.0/voices-v1.0.bin
RUN wget https://github.com/nazdridoy/kokoro-tts/releases/download/v1.0.0/kokoro-v1.0.onnx

RUN apt-get update && apt-get install -y libportaudio2

RUN echo "uv run /kokoro-tts/kokoro-tts /dev/stdin output.wav --voice af_nicole > /dev/null && cat output.wav" > /entrypoint

RUN chmod +x /entrypoint

ENTRYPOINT /entrypoint
