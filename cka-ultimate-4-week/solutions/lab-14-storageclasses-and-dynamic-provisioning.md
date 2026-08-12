# Solution — Lab 14: StorageClasses and Dynamic Provisioning

This is a **reference path**, not the only valid solution. On CKA, satisfy the requested end state and verify it.

## Intended approach

1. Inspect classes first.
2. Create claim using a real class and prove a PV is generated.
3. Use a nonexistent/fake class to learn Pending evidence.

## Canonical commands / evidence

```bash
kubectl get sc -o wide
kubectl get pvc -n cka-storage -w
kubectl describe pvc broken-pvc -n cka-storage
```

## Expected evidence

- Real dynamic claim has a provisioner-created PV.
- Nonexistent class produces events/no binding rather than a Kubernetes-created disk by magic.

## Common traps

- Assuming every cluster ships a default StorageClass.
- Creating a StorageClass with an arbitrary provisioner name and expecting a controller to appear.

## Explain it back

State the control-loop/API reason the solution works, and name the first two observations you would use if it did not.
