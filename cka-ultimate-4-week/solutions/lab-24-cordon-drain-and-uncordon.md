# Solution — Lab 24: Cordon, Drain and Uncordon

This is a **reference path**, not the only valid solution. On CKA, satisfy the requested end state and verify it.

## Intended approach

1. Cordon prevents new scheduling.
2. Drain evicts eligible workloads according to policy/flags.
3. Uncordon restores scheduling.

## Canonical commands / evidence

```bash
kubectl cordon worker01
kubectl drain worker01 --ignore-daemonsets --delete-emptydir-data
kubectl get pods -A -o wide --field-selector spec.nodeName=worker01
kubectl uncordon worker01
```

## Expected evidence

- Node field/display changes as expected.
- Deployment controller replaces evicted Pods on eligible nodes.

## Common traps

- Using `--force`/`--delete-emptydir-data` without reading what data/workloads are affected.
- Forgetting to uncordon.

## Explain it back

State the control-loop/API reason the solution works, and name the first two observations you would use if it did not.
