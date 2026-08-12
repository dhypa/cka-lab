# Solution — Lab 03: Labels, Selectors and Controller Ownership

This is a **reference path**, not the only valid solution. On CKA, satisfy the requested end state and verify it.

## Intended approach

1. Patch/edit Deployment Pod-template labels so controller-created Pods inherit the label.
2. Expose/select Pods and use EndpointSlice as evidence.

## Canonical commands / evidence

```bash
kubectl label deploy web -n cka-lab tier=frontend --overwrite
kubectl patch deploy web -n cka-lab -p '{"spec":{"template":{"metadata":{"labels":{"tier":"frontend"}}}}}'
kubectl expose deploy web -n cka-lab --name=web-label-test --port=80 --target-port=80
kubectl patch svc web-label-test -n cka-lab -p '{"spec":{"selector":{"app":"web","tier":"frontend"}}}'
```

## Expected evidence

- All replacement Pods carry the new template label.
- EndpointSlice contains backend addresses after selector repair.

## Common traps

- Changing only Deployment metadata labels, which do not alter Pod-template labels.
- Assuming Service health from Service existence without inspecting endpoints.

## Explain it back

State the control-loop/API reason the solution works, and name the first two observations you would use if it did not.
