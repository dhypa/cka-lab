#!/usr/bin/env bash
set -euo pipefail
ssh worker02 'sudo systemctl stop kubelet'
