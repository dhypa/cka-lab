#!/usr/bin/env bash
set -euo pipefail
echo '== identity =='
hostname
kubectl config current-context
echo
echo '== nodes =='
kubectl get nodes -o wide
echo
echo '== non-running pods =='
kubectl get pods -A --field-selector=status.phase!=Running || true
echo
echo '== recent events =='
kubectl get events -A --sort-by=.lastTimestamp | tail -30 || true
echo
echo '== control plane =='
kubectl -n kube-system get pods -o wide || true
