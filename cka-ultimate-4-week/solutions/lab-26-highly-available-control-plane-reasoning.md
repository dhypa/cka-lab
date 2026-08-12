# Solution — Lab 26: Highly Available Control Plane Reasoning

This is a **reference path**, not the only valid solution. On CKA, satisfy the requested end state and verify it.

## Intended approach

1. Read live kubeadm config.
2. Model endpoint/control-plane/etcd relationships.
3. Use official HA docs for join flow; build it if resources permit.

## Canonical commands / evidence

```bash
kubectl -n kube-system get cm kubeadm-config -o yaml
kubeadm token create --print-join-command
```

## Expected evidence

- Architecture diagram includes a stable API endpoint separate from individual node addresses.
- Quorum reasoning is correct for odd-sized etcd membership.

## Common traps

- Equating multiple workers with HA control plane.
- Ignoring etcd quorum while counting API server replicas.

## Explain it back

State the control-loop/API reason the solution works, and name the first two observations you would use if it did not.
