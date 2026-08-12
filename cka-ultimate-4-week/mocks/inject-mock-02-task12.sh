#!/usr/bin/env bash
set -euo pipefail
ssh controlplane 'set -e; sudo test -f /etc/kubernetes/manifests/kube-scheduler.yaml; sudo cp /etc/kubernetes/manifests/kube-scheduler.yaml /tmp/kube-scheduler.yaml.mock2; sudo rm /etc/kubernetes/manifests/kube-scheduler.yaml'
