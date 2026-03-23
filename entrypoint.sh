#!/bin/sh
set -e

ACTUAL_PORT="${PORT:-42617}"

# เขียน config เฉพาะครั้งแรกเท่านั้น
if [ ! -f /zeroclaw-data/.zeroclaw/config.toml ]; then
  echo "📝 Creating config for the first time..."
  mkdir -p /zeroclaw-data/.zeroclaw /zeroclaw-data/workspace
  cat > /zeroclaw-data/.zeroclaw/config.toml << EOF
api_key = "${API_KEY}"
default_provider = "${PROVIDER:-openrouter}"
default_model = "${ZEROCLAW_MODEL:-anthropic/claude-sonnet-4-6}"
default_temperature = 0.7

[gateway]
port = ${ACTUAL_PORT}
host = "[::]"
allow_public_bind = true
require_pairing = false

[memory]
backend = "sqlite"
auto_save = true
EOF
else
  echo "✅ Config already exists, skipping..."
fi

exec zeroclaw daemon
```

---

## สาเหตุที่แก้ได้
```
ก่อนแก้:  ทุก restart → เขียน config ใหม่ → memory หาย
หลังแก้:  restart ครั้งแรก → เขียน config
          restart ครั้งต่อไป → ใช้ config เดิม → memory คงอยู่ ✅
