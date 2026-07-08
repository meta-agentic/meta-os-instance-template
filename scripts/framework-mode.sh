#!/usr/bin/env bash
# Flip the framework mounts between the two consumption modes (see the framework's
# systems/distribution.md): "submodule" (.meta-os/*, the single-clone default) or
# "sibling" (../meta-os/*, developer mode for hacking the framework itself).
set -euo pipefail
mode="${1:-}"
case "$mode" in
  submodule)
    target=".meta-os"
    [ -f .meta-os/CLAUDE.md ] || git submodule update --init .meta-os
    ;;
  sibling)
    target="../meta-os"
    [ -f ../meta-os/CLAUDE.md ] || { echo "no sibling meta-os checkout next to this repo" >&2; exit 1; }
    ;;
  *)
    echo "usage: $0 submodule|sibling" >&2
    exit 1
    ;;
esac
for d in agents skills systems templates; do
  ln -sfn "$target/$d" "$d"
done
echo "framework mounts → $target/*"
