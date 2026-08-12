#!/usr/bin/env bash
set -euo pipefail
namespaces=(
  cka-lab cka-config cka-schedule cka-net cka-storage cka-debug
  cka-rbac cka-helm cka-kustomize-dev cka-kustomize-prod cka-gateway
  cka-crd cka-hpa cka-capstone
)
for ns in "${namespaces[@]}"; do
  kubectl delete namespace "$ns" --ignore-not-found --wait=false
 done
 echo 'Deletion requested. Cluster-scoped lab objects (PVs, CRDs, ClusterRoles, GatewayClasses, labels/taints) are intentionally NOT deleted automatically.'
