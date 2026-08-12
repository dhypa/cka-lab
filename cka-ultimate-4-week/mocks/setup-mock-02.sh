#!/usr/bin/env bash
set -euo pipefail
for ns in mock2-app mock2-net mock2-rbac mock2-storage mock2-modern; do kubectl delete ns "$ns" --ignore-not-found --wait=true >/dev/null 2>&1 || true; kubectl create ns "$ns" >/dev/null; done
kubectl delete crd widgets.training.cka.io --ignore-not-found >/dev/null 2>&1 || true
kubectl label node worker01 workload=general --overwrite >/dev/null 2>&1 || true
kubectl label node worker02 workload=special --overwrite >/dev/null 2>&1 || true
kubectl create deploy svc-bug -n mock2-app --image=nginx:1.27 --replicas=2 >/dev/null
kubectl expose deploy svc-bug -n mock2-app --port=8080 --target-port=80 >/dev/null
kubectl patch svc svc-bug -n mock2-app -p '{"spec":{"ports":[{"port":8080,"targetPort":8089}]}}' >/dev/null
printf 'mock2 setup complete\n'
