# Solution — Lab 09: nodeSelector and Node Affinity

This is a **reference path**, not the only valid solution. On CKA, satisfy the requested end state and verify it.

## Intended approach

1. Label nodes.
2. Create selector-constrained and impossible Pods; read scheduler events.
3. Author requiredDuringSchedulingIgnoredDuringExecution affinity.

## Canonical commands / evidence

```bash
kubectl create ns cka-schedule
kubectl label node worker01 disk=ssd
kubectl label node worker02 disk=hdd
kubectl get pod -n cka-schedule -o wide
kubectl describe pod nvme-pod -n cka-schedule
```

## Expected evidence

- Scheduler places only on matching labels.
- Impossible required constraint leaves Pod Pending with useful events.

## Common traps

- Using `nodeName` when task asks for selector/affinity.
- Confusing required and preferred affinity.

## Explain it back

State the control-loop/API reason the solution works, and name the first two observations you would use if it did not.
