# Solution — Lab 04: Pod Lifecycle, Events, Logs and Previous Logs

This is a **reference path**, not the only valid solution. On CKA, satisfy the requested end state and verify it.

## Intended approach

1. Create a crashing Pod and wait for restart.
2. Inspect status/events and previous logs before editing.
3. Replace/recreate with a stable command and observe.

## Canonical commands / evidence

```bash
kubectl create ns cka-debug 2>/dev/null || true
kubectl run bad-image -n cka-debug --image=nginx:definitely-not-real --restart=Never
kubectl describe pod bad-image -n cka-debug
kubectl logs crasher -n cka-debug --previous
```

## Expected evidence

- Events for bad image mention image pull failure.
- Previous logs preserve output from a terminated instance while restart policy replaces it.

## Common traps

- Looking only at Pod phase `Running` while a container is repeatedly restarting.
- Trying `logs --previous` before a prior container instance exists.

## Explain it back

State the control-loop/API reason the solution works, and name the first two observations you would use if it did not.
