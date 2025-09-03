#!/usr/bin/env bash
set -euo pipefail

DOCKER_USER=${DOCKER_USER:-karthickm13799}  # <-- set your Docker Hub username
TARGET=${1:-dev}                            # dev | prod
TAG=${2:-latest}

case "$TARGET" in
  dev)  REPO="$DOCKER_USER/dev"  ;;
  prod) REPO="$DOCKER_USER/prod" ;;
  *) echo "Usage: $0 [dev|prod] [tag]"; exit 1 ;;
esac

export IMAGE="$REPO:$TAG"
docker compose pull || true
docker compose down
docker compose up -d
docker ps
