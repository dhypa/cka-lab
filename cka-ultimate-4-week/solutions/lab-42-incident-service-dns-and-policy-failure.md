# Solution — Lab 42: Incident: Service, DNS and Policy Failure

This is a **reference path**, not the only valid solution. On CKA, satisfy the requested end state and verify it.

## Intended approach

1. Establish healthy baseline.
2. Inject independent transport/policy faults.
3. Prove DNS separately.
4. Inspect Service endpoints/port then policies/labels.
5. Verify positive and negative client.

## Canonical commands / evidence

```bash
kubectl get svc api -n cka-net -o yaml
kubectl get endpointslice -n cka-net -l kubernetes.io/service-name=api -o yaml
kubectl get pod -n cka-net --show-labels
kubectl get netpol -n cka-net -o yaml
```

## Expected evidence

- Final denied path stays denied by design.
- Allowed path succeeds through Service DNS.

## Common traps

- Deleting all NetworkPolicies to make traffic work.
- Concluding DNS is broken because HTTP by name times out.

## Explain it back

State the control-loop/API reason the solution works, and name the first two observations you would use if it did not.
