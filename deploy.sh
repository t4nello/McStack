#!/bin/bash

if ! command -v htpasswd &> /dev/null; then
  echo "Error: 'htpasswd' command not found. Install 'apache2-utils' (Debian/Ubuntu) or 'httpd-tools' (RHEL/CentOS)."
  exit 1
fi

if [ ! -f "./management/usersfile" ]; then
  echo "Error: 'usersfile' has not been found."
  echo "Create it using:"
  echo "  htpasswd -Bc -C 6 ./management/usersfile <username>"
  exit 1
fi

PORT="${1:-25565}"

if ! [[ "$PORT" =~ ^[0-9]+$ ]] || [ "$PORT" -lt 1 ] || [ "$PORT" -gt 65535 ]; then
  echo "Error: Port number must be an integer from range 1–65535."
  exit 1
fi

echo "MINECRAFT_SERVER_PORT=$PORT" > ./management/management-stack.env
echo "Minecraft server port is set to: $PORT"

set -a
. ./management/management-stack.env
set +a

for NET in management monitoring minecraft; do
  docker network create --opt "com.docker.network.bridge.name=$NET" "$NET" \
    2>/dev/null || echo "Network '$NET' already exists."
done

docker compose -f ./management/docker-compose.yml -p management up -d
