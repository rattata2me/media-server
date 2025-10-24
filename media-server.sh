#!/bin/bash
# media-server.sh - Control script for Docker Compose media server

set -e

COMPOSE_FILE="docker-compose.yaml"

check_docker() {
  if ! command -v docker &>/dev/null; then
    echo "Docker is not installed. Please install Docker." >&2
    exit 1
  fi
  if ! docker compose version &>/dev/null; then
    echo "Docker Compose is not available. Please install Docker Compose v2 (integrated with Docker)." >&2
    exit 1
  fi
}

case "$1" in
  start)
    check_docker
    docker compose -f "$COMPOSE_FILE" up -d
    ;;
  stop)
    check_docker
    docker compose -f "$COMPOSE_FILE" stop
    ;;
  down)
    check_docker
    docker compose -f "$COMPOSE_FILE" down
    ;;
  update)
    check_docker
    docker compose -f "$COMPOSE_FILE" pull
    docker compose -f "$COMPOSE_FILE" up -d --remove-orphans
    ;;
  clean)
    check_docker
    docker compose -f "$COMPOSE_FILE" down
    docker image prune -af --filter label=com.docker.compose.project=$(basename "$PWD")
    docker compose -f "$COMPOSE_FILE" pull
    docker compose -f "$COMPOSE_FILE" up -d --remove-orphans
    ;;
  *)
    echo "Usage: $0 {start|stop|down|update|clean}"
    exit 1
    ;;
esac
