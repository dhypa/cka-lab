# Solution — Lab 38: Install and Inspect an Operator

This is a **reference path**, not the only valid solution. On CKA, satisfy the requested end state and verify it.

## Intended approach

1. Install only from current project docs.
2. Inventory controller/CRDs/RBAC.
3. Create CR and watch logs/status/children.
4. Change spec and prove reconcile loop.

## Canonical commands / evidence

```bash
kubectl get crd
kubectl get events -A --sort-by=.lastTimestamp | tail -30
```

## Expected evidence

- Behaviour is tied to a running controller, unlike bare CRD.
- RBAC explains what the controller is allowed to mutate.

## Common traps

- Installing a huge operator stack that consumes the whole practice cluster.
- Calling status change “magic” without locating controller/logs.

## Explain it back

State the control-loop/API reason the solution works, and name the first two observations you would use if it did not.
