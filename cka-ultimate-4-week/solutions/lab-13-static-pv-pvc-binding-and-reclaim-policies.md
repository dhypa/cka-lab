# Solution — Lab 13: Static PV/PVC Binding and Reclaim Policies

This is a **reference path**, not the only valid solution. On CKA, satisfy the requested end state and verify it.

## Intended approach

1. Apply static PV/PVC and wait for Bound.
2. Mount, write, recreate, read.
3. Delete claim and inspect Retain state.

## Canonical commands / evidence

```bash
kubectl apply -f assets/storage-static.yaml
kubectl get pv,pvc -A
kubectl describe pvc cka-static-pvc -n cka-storage
```

## Expected evidence

- ClaimRef points from PV to PVC while bound.
- Data persists across Pod replacement because storage lifetime is independent of Pod.

## Common traps

- Using `hostPath` as if it were production shared storage; it is only convenient for this VM lab.
- Deleting the PVC before verifying data/workload behaviour.

## Explain it back

State the control-loop/API reason the solution works, and name the first two observations you would use if it did not.
