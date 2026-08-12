# Solution — Lab 39: Horizontal Pod Autoscaling

This is a **reference path**, not the only valid solution. On CKA, satisfy the requested end state and verify it.

## Intended approach

1. Prove metrics first.
2. Create resource-requested workload.
3. Create HPA and generate load.
4. Inspect conditions, not only replica count.

## Canonical commands / evidence

```bash
kubectl top pods -A
kubectl autoscale deploy cpu-web -n cka-hpa --cpu-percent=50 --min=1 --max=5
kubectl get hpa -n cka-hpa -w
```

## Expected evidence

- HPA can calculate CPU percentage relative to requests.
- Scaling is controller-driven and not instantaneous.

## Common traps

- Trying CPU utilisation HPA with no CPU requests and ignoring metric status.
- Expecting immediate scale-down after load stops.

## Explain it back

State the control-loop/API reason the solution works, and name the first two observations you would use if it did not.
