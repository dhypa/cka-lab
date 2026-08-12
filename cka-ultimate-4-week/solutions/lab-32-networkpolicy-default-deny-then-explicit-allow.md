# Solution — Lab 32: NetworkPolicy: Default Deny then Explicit Allow

This is a **reference path**, not the only valid solution. On CKA, satisfy the requested end state and verify it.

## Intended approach

1. Prove baseline.
2. Apply default deny and prove changed behaviour.
3. Add narrow allow and test positive/negative clients.

## Canonical commands / evidence

```bash
kubectl apply -f assets/networkpolicy-seed.yaml
kubectl get netpol -n cka-net
kubectl exec -n cka-net client-allowed -- wget -T 3 -qO- http://api
```

## Expected evidence

- Policy enforcement is observed, not assumed.
- Only labelled client has intended path.

## Common traps

- Using a CNI that does not enforce NetworkPolicy and concluding YAML is wrong.
- Writing a `from` structure whose selector boolean logic differs from intention.
- Forgetting DNS egress when adding egress-deny.

## Explain it back

State the control-loop/API reason the solution works, and name the first two observations you would use if it did not.
