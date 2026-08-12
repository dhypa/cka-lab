# Mock 1 Solution Map

Read only after the timed attempt and independent remediation.

| Task | Core approach | Closest course labs |
|---:|---|---|
| 1 | `kubectl run`; `kubectl config set-context --current --namespace=...` | 01, 46, 47 |
| 2 | create/set-image/rollout status/history/undo | 07 |
| 3 | ConfigMap/Secret + `env.valueFrom` | 05 |
| 4 | node labels + `nodeSelector` | 09 |
| 5 | taint + toleration + node selector, then remove taint | 10 |
| 6 | readiness `/`; Service selector `app=mock-broken`; targetPort 80; verify endpoints+HTTP | 06, 11, 41 |
| 7 | disposable BusyBox `nslookup` with FQDN, redirect real output | 12 |
| 8 | default/narrow ingress policy with Pod selector and TCP/80; positive+negative tests | 32 |
| 9 | working SC or static compatible PV/PVC; mount/write/recreate/read | 13, 14 |
| 10 | Role/RoleBinding for Pods; ClusterRole/ClusterRoleBinding for Nodes; `auth can-i` | 20, 21 |
| 11 | CPU request + HPA targetRef/min/max/60%; metrics may be unavailable | 39 |
| 12 | `helm install` then `helm upgrade`, rollout/history | 28 |
| 13 | `kubectl kustomize` then `apply -k`; do not modify base | 29 |
| 14 | apply CRD, wait Established, create valid Widget, API schema rejection | 37 |
| 15 | inventory CRDs/classes/Gateway, author route; status honesty | 34, 35 |
| 16 | Node conditions → SSH → systemctl/journal → restore kubelet → Ready | 43 |
| 17 | kubeadm certs, token join command, etcd manifest TLS/endpoints | 22, 23, 49 |

For exact commands, use the referenced lab solution only after you have tried to rebuild the skill yourself.
