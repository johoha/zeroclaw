#!/bin/sh
set -e

ACTUAL_PORT="${PORT:-42617}"

# เขียน config ใหม่ทั้งหมดเลย แทนที่จะใช้ sed แก้
cat > /zeroclaw-data/.zeroclaw/config.toml << EOF
workspace_dir = "/zeroclaw-data/workspace"
api_key = "${API_KEY}"
default_provider = "${PROVIDER:-openrouter}"
default_model = "${ZEROCLAW_MODEL:-anthropic/claude-sonnet-4-6}"
default_temperature = 0.7

[gateway]
port = ${ACTUAL_PORT}
host = "[::]"
allow_public_bind = true
require_pairing = false
EOF

exec zeroclaw daemon
