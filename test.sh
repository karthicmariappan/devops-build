#!/usr/bin/env bash
set -euo pipefail

# Build a DEV image
export DOCKER_USER=karthickm13799
./build.sh dev v1

# Run it locally with compose
export IMAGE=$DOCKER_USER/dev:v1
docker compose up -d

# Test application
echo "Testing http://localhost ..."
curl -I http://localhost || true
