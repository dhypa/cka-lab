# Solution — Lab 33: Ingress Resource and Controller Path

This is a **reference path**, not the only valid solution. On CKA, satisfy the requested end state and verify it.

## Intended approach

1. Inventory class/controller.
2. Create backend and Ingress.
3. Use status/controller evidence.
4. Repair bad backend reference.

## Canonical commands / evidence

```bash
kubectl get ingressclass
kubectl get ingress -A
kubectl describe ingress web -n cka-ingress
```

## Expected evidence

- Resource validity and data-plane readiness are treated as separate claims.
- Backend Service has endpoints.

## Common traps

- Assuming Kubernetes core includes an Ingress controller.
- Testing traffic before identifying the controller/address/class.

## Explain it back

State the control-loop/API reason the solution works, and name the first two observations you would use if it did not.
