# CKA Skill Matrix

Rate each row **R / A / G** before Day 1, after Day 14, and after Day 28.

| Skill | Domain | Day 1 | Day 14 | Day 28 |
|---|---|---|---|---|
| Host/context/namespace safety | Exam execution |  |  |  |
| Generate/edit YAML quickly | Workloads |  |  |  |
| Labels/selectors/ownership | Workloads |  |  |  |
| Logs/events/describe/previous logs | Troubleshooting |  |  |  |
| ConfigMaps/Secrets | Workloads |  |  |  |
| Requests/limits/probes | Workloads |  |  |  |
| Rollouts/history/rollback | Workloads |  |  |  |
| DaemonSets/self-healing | Workloads |  |  |  |
| nodeSelector/affinity | Scheduling |  |  |  |
| Taints/tolerations/drain | Scheduling/Admin |  |  |  |
| Services/ports/selectors/EndpointSlices | Networking |  |  |  |
| CoreDNS/service discovery | Networking |  |  |  |
| Static PV/PVC/reclaim policy | Storage |  |  |  |
| StorageClasses/dynamic provisioning | Storage |  |  |  |
| Control-plane/static-Pod architecture | Cluster |  |  |  |
| kubeadm init/join/reset | Cluster |  |  |  |
| kubeconfig/context/client identity | Cluster |  |  |  |
| RBAC/`auth can-i` | Cluster |  |  |  |
| ServiceAccount RBAC | Cluster |  |  |  |
| etcd snapshot/restore | Cluster |  |  |  |
| Certificates/expiry inspection | Cluster |  |  |  |
| kubeadm upgrade workflow | Cluster |  |  |  |
| HA control-plane reasoning | Cluster |  |  |  |
| Identify CNI/CRI/CSI responsibility | Cluster |  |  |  |
| Helm lifecycle | Cluster |  |  |  |
| Kustomize bases/overlays/patches | Cluster |  |  |  |
| NetworkPolicy | Networking |  |  |  |
| Ingress | Networking |  |  |  |
| Gateway API | Networking |  |  |  |
| CRDs/schema validation | Cluster |  |  |  |
| Operator inspection | Cluster |  |  |  |
| HPA | Workloads |  |  |  |
| Node `NotReady` diagnosis | Troubleshooting |  |  |  |
| Control-plane failure diagnosis | Troubleshooting |  |  |  |
| Multi-layer application outage diagnosis | Troubleshooting |  |  |  |
| Official-doc lookup under time pressure | Exam execution |  |  |  |
| Timeboxing/skipping/review | Exam execution |  |  |  |

## Green test

A skill is Green only if you can satisfy a terse task such as “Create a policy that permits only X to reach Y on TCP 8080” without a tutorial, find syntax in allowed docs quickly, verify the policy, and explain one likely failure mode.
