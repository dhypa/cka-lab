# Solution — Lab 48: Timed Networking Circuit

This is a **reference path**, not the only valid solution. On CKA, satisfy the requested end state and verify it.

## Intended approach

1. Build/verify baseline.
2. Add default-deny then narrow allow.
3. Inject/repair selector fault.
4. Capture DNS output.
5. Attempt Gateway syntax only if API exists.

## Canonical commands / evidence

```bash
kubectl get endpointslice -n cka-net-speed
kubectl get netpol -n cka-net-speed -o yaml
```

## Expected evidence

- Timer includes verification.
- Denied path remains denied after repairs.

## Common traps

- Spending half circuit installing optional controller.
- Opening network access broadly to make one request pass.

## Explain it back

State the control-loop/API reason the solution works, and name the first two observations you would use if it did not.
