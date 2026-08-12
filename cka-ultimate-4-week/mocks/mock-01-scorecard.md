# Mock 1 Scorecard — 100 Points

Award points from end-state evidence. Use partial credit only where explicitly split below.

| Task | Pts | Verification / scoring |
|---:|---:|---|
| 1 | 4 | Pod Running (2), current-context namespace mock1-app (1), output file correct (1) |
| 2 | 7 | final 3 Ready working replicas (4), history file (1), failed rollout recognised then rollback reflected in history/state (2) |
| 3 | 5 | ConfigMap+Secret exist (2), Deployment env references both objects and new Pods receive values (3) |
| 4 | 5 | Pod Running on mockdisk=fast node (4), uses nodeSelector not nodeName (1) |
| 5 | 5 | Pod Running worker02 with toleration+selector (4), practice taint removed (1) |
| 6 | 7 | 2 Ready (2), selector/endpoints fixed (2), backend port/probe fixed (2), HTTP succeeds (1) |
| 7 | 4 | output file from real lookup (2), correct FQDN resolves (2) |
| 8 | 7 | api Service/backends (2), policy syntax selects api (2), A succeeds (1.5), B denied (1.5) |
| 9 | 6 | PVC Bound (2), mounted (1), persisted marker survives Pod recreation (3) |
| 10 | 7 | namespaced Pod read (2), cluster Node list (2), negative deletes (2), least-privilege structure (1) |
| 11 | 5 | request present (1), HPA target/min/max/60% correct (4) |
| 12 | 6 | release in correct ns (2), final 4 healthy replicas (2), history file showing upgrade (2) |
| 13 | 6 | render file (1), prod applied correct namespace/name (2), 3 replicas (1), resources patch (2) |
| 14 | 5 | CRD Established (1), valid Widget (2), output file (1), schema would reject size 0 (1) |
| 15 | 6 | capability branch handled correctly (2), valid route/backend/parent refs where APIs exist (2), required output/status evidence and no false live claim (2) |
| 16 | 9 | cause diagnosed (3), worker02 Ready (3), kubelet/runtime active (1), Conditions output file (2) |
| 17 | 6 | cert file (2), 600 join file (2), etcd input paths correct (2); snapshot is bonus practice, not extra score |

## Verification snippets

```bash
kubectl get pods -n mock1-app -o wide
kubectl rollout status deploy/frontend -n mock1-app --timeout=10s
kubectl get endpointslice -n mock1-app -l kubernetes.io/service-name=mock-broken
kubectl auth can-i list nodes --as=system:serviceaccount:mock1-rbac:auditor
kubectl auth can-i delete nodes --as=system:serviceaccount:mock1-rbac:auditor
kubectl get pvc -n mock1-storage
helm history mock1-web -n mock1-modern
kubectl get widget exam-widget -n mock1-modern
kubectl get node worker02
```

**Raw score: ____ / 100**  
**Time used: ____ / 120 min**  
**Course gate met (≥75): yes / no**

### Miss taxonomy

| Task | Points lost | tag | exact cause | remediation lab |
|---|---:|---|---|---|
| | | | | |
