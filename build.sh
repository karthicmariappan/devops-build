#!/usr/bin/env bash
set -euo pipefail

APP_NAME=devops-build
DOCKER_USER=${DOCKER_USER:-karthickm13799}   # <-- your Docker Hub username
TARGET=${1:-dev}                             # dev | prod
VERSION=${2:-$(date +%Y.%m.%d-%H%M)}         # version or timestamp

case "$TARGET" in
  dev)  REPO="$DOCKER_USER/dev"  ;;
  prod) REPO="$DOCKER_USER/prod" ;;
  *) echo "Usage: $0 [dev|prod] [version]"; exit 1 ;;
esac

IMAGE="$REPO:$VERSION"
LATEST="$REPO:latest"

echo "🚀 Building Docker image: $IMAGE ..."
docker build -t "$IMAGE" -t "$LATEST" .

echo "🔑 Logging in to Docker Hub as $DOCKER_USER ..."
docker login -u "$DOCKER_USER"

echo "📤 Pushing images to Docker Hub..."
docker push "$IMAGE"
docker push "$LATEST"

echo "✅ Done! Successfully pushed:"
echo "   - $IMAGE"
echo "   - $LATEST"
