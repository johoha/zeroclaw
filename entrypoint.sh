#!/bin/sh
set -e

# อัปเดต port ใน config ให้ตรงกับที่ Railway กำหนด
ACTUAL_PORT="${PORT:-42617}"

sed -i "s/port = 42617/port = ${ACTUAL_PORT}/" /zeroclaw-data/.zeroclaw/config.toml

# ใส่ API Key ถ้ามีการตั้งค่าไว้
if [ -n "$API_KEY" ]; then
  sed -i "s/api_key = \"\"/api_key = \"${API_KEY}\"/" /zeroclaw-data/.zeroclaw/config.toml
fi

exec zeroclaw daemon
