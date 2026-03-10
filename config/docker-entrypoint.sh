#!/bin/sh

set -e

#
# Install another node version if specified as an environment variable
#
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

#
# Add the html folder as a trusted git folder to suppress "dubious ownership" warnings
#
git config --global --add safe.directory /var/www/html


exec "$@"
