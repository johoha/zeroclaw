FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
    curl ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Download pre-built binary แทนการ compile
RUN curl -fsSLO https://github.com/zeroclaw-labs/zeroclaw/releases/download/v0.5.9/zeroclaw-x86_64-unknown-linux-gnu.tar.gz \
    && tar xzf zeroclaw-x86_64-unknown-linux-gnu.tar.gz \
    && install -m 0755 zeroclaw /usr/local/bin/zeroclaw \
    && rm -f zeroclaw-x86_64-unknown-linux-gnu.tar.gz

# สร้าง directory และ config เริ่มต้น
RUN mkdir -p /zeroclaw-data/.zeroclaw /zeroclaw-data/workspace && \
    printf '%s\n' \
        'workspace_dir = "/zeroclaw-data/workspace"' \
        'api_key = ""' \
        'default_provider = "openrouter"' \
        'default_model = "anthropic/claude-sonnet-4-6"' \
        'default_temperature = 0.7' \
        '' \
        '[gateway]' \
        'port = 42617' \
        'host = "[::]"' \
        'allow_public_bind = true' \
        > /zeroclaw-data/.zeroclaw/config.toml

ENV LANG=C.UTF-8
ENV ZEROCLAW_WORKSPACE=/zeroclaw-data/workspace
ENV HOME=/zeroclaw-data
ENV ZEROCLAW_GATEWAY_PORT=42617

WORKDIR /zeroclaw-data
EXPOSE 42617

ENTRYPOINT ["zeroclaw"]
CMD ["daemon"]
