# Mock 2 Solution Map

| Task | Core approach | Closest labs |
|---:|---|---|
| 1 | Deployment resources/readiness + Service + HTTP | 06, 11 |
| 2 | DaemonSet on eligible worker nodes | 08 |
| 3 | requiredDuringSchedulingIgnoredDuringExecution on workload=special | 09 |
| 4 | targetPort should reach nginx 80; prove via EndpointSlice+HTTP | 11, 42 |
| 5 | FQDN from other namespace, separate resolution and HTTP | 12, 31 |
| 6 | ingress policy selecting internal, allow trusted Pod selector TCP/80 | 32 |
| 7 | static PV/PVC compatible class/access/size, Retain | 13 |
| 8 | Role+RoleBinding to ServiceAccount; namespace boundaries | 20, 21 |
| 9 | cordon, inspect, uncordon | 24 |
| 10 | Helm history, broken upgrade, rollback working revision | 28 |
| 11 | new overlay referencing base with namespace/namePrefix/replicas | 29 |
| 12 | missing `/etc/kubernetes/manifests/kube-scheduler.yaml`; locate `/tmp/kube-scheduler.yaml.mock2`, restore to manifest dir; kubelet recreates scheduler | 16, 44 |
| 13 | CRD apply/wait, valid CR, `kubectl explain`, invalid API rejection | 37 |
| 14 | HPA correct spec independent of metrics availability | 39 |
| 15 | inventory Gateway APIs/classes and create/status HTTPRoute honestly | 34, 35 |
| 16 | node versions + kubeadm cert inventory + fresh token/join | 18, 23, 49 |
| 17 | read endpoint/TLS/data values from `/etc/kubernetes/manifests/etcd.yaml` | 22 |
