#!/usr/bin/env bash
set -euo pipefail
for ns in mock1-app mock1-net mock1-rbac mock1-storage mock1-modern; do kubectl delete ns "$ns" --ignore-not-found --wait=true >/dev/null 2>&1 || true; kubectl create ns "$ns" >/dev/null; done
kubectl delete deploy mock-broken -n mock1-app --ignore-not-found >/dev/null 2>&1 || true
kubectl create deploy mock-broken -n mock1-app --image=nginx:1.27 --replicas=2 >/dev/null
kubectl patch deploy mock-broken -n mock1-app --type='merge' -p '{"spec":{"template":{"spec":{"containers":[{"name":"nginx","image":"nginx:1.27","readinessProbe":{"httpGet":{"path":"/bad-health","port":80},"periodSeconds":3}}]}}}}' >/dev/null
kubectl expose deploy mock-broken -n mock1-app --name=mock-broken --port=80 --target-port=8088 >/dev/null
kubectl patch svc mock-broken -n mock1-app -p '{"spec":{"selector":{"app":"wrong-selector"}}}' >/dev/null
kubectl label node worker01 mockdisk=fast --overwrite >/dev/null 2>&1 || true
kubectl label node worker02 mockdisk=slow --overwrite >/dev/null 2>&1 || true
printf 'mock1 setup complete\n'
