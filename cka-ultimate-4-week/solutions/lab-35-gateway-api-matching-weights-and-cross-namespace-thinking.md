# Solution — Lab 35: Gateway API: Matching, Weights and Cross-Namespace Thinking

This is a **reference path**, not the only valid solution. On CKA, satisfy the requested end state and verify it.

## Intended approach

1. Create distinguishable backends.
2. Author matching + weighted refs.
3. Observe status/live distribution if controller exists.
4. Test cross-namespace rejection then grant.

## Canonical commands / evidence

```bash
kubectl get httproute -n cka-gateway -o yaml
kubectl describe httproute -n cka-gateway
```

## Expected evidence

- Status provides reference-resolution evidence.
- ReferenceGrant is located in the target namespace.

## Common traps

- Expecting exact request counts from weights.
- Putting ReferenceGrant in source namespace.
- Assuming cross-namespace is allowed by default.

## Explain it back

State the control-loop/API reason the solution works, and name the first two observations you would use if it did not.
