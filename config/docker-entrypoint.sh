#!/bin/sh

set -e

if [ -n "${NODE_VERSION:-}" ]; then
  current="$(node -v 2>/dev/null || true)"
  need_install=1

  case "$NODE_VERSION" in
    lts|stable|latest)
      need_install=1
      ;;
    v*.*.*|*.*.*)
      case "$NODE_VERSION" in
        v*) desired="$NODE_VERSION" ;;
        *) desired="v$NODE_VERSION" ;;
      esac

      if [ "$current" = "$desired" ]; then
        need_install=0
      fi
      ;;
    *)
      if printf '%s' "$current" | grep -q "^v${NODE_VERSION}\\."; then
        need_install=0
      fi
      ;;
  esac

  if [ "$need_install" -eq 1 ]; then
    n "$NODE_VERSION"
    corepack enable >/dev/null 2>&1 || true
  fi
fi

exec "$@"