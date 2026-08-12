# Solution — Lab 12: CoreDNS and Service Discovery

This is a **reference path**, not the only valid solution. On CKA, satisfy the requested end state and verify it.

## Intended approach

1. Test short and FQDN forms from different namespaces.
2. Inspect CoreDNS workloads/service and Pod resolver configuration.
3. Compare DNS and backend failures.

## Canonical commands / evidence

```bash
kubectl exec -n cka-net CLIENT -- cat /etc/resolv.conf
kubectl -n kube-system get deploy coredns
kubectl -n kube-system get configmap coredns -o yaml
```

## Expected evidence

- DNS Service and CoreDNS Pods are healthy.
- FQDN resolves cross-namespace.

## Common traps

- Assuming every “connection failed” symptom is DNS.
- Testing a namespace-local short name from the wrong namespace and concluding DNS is broken.

## Explain it back

State the control-loop/API reason the solution works, and name the first two observations you would use if it did not.
