#!/usr/bin/env bash
set -euo pipefail

CLOUD_INIT="./cloud-init/k8s-node.yaml"

if ! command -v multipass >/dev/null 2>&1; then
  echo "Error: multipass is not installed or not on PATH." >&2
  exit 1
fi

if [[ ! -f "$CLOUD_INIT" ]]; then
  echo "Error: cloud-init file not found at $CLOUD_INIT" >&2
  exit 1
fi

multipass launch 24.04 \
  --name controlplane \
  --cpus 2 \
  --memory 3G \
  --disk 20G \
  --cloud-init "$CLOUD_INIT"

multipass launch 24.04 \
  --name worker01 \
  --cpus 2 \
  --memory 2G \
  --disk 20G \
  --cloud-init "$CLOUD_INIT"

multipass launch 24.04 \
  --name worker02 \
  --cpus 2 \
  --memory 2G \
  --disk 20G \
  --cloud-init "$CLOUD_INIT"
