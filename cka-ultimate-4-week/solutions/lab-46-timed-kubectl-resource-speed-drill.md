# Solution — Lab 46: Timed kubectl Resource Speed Drill

This is a **reference path**, not the only valid solution. On CKA, satisfy the requested end state and verify it.

## Intended approach

1. Use imperative generators for skeletons.
2. Patch/edit only needed fields.
3. Verify RBAC/rollout/output file.

## Canonical commands / evidence

```bash
kubectl create ns cka-speed
kubectl create deploy d1 -n cka-speed --image=nginx:1.27 --replicas=3
kubectl expose deploy d1 -n cka-speed --port=8080 --target-port=80
kubectl create role pod-reader -n cka-speed --verb=get,list --resource=pods
```

## Expected evidence

- Circuit output matches names/requirements.
- Recorded time improves on repeat.

## Common traps

- Typing full YAML for every simple object.
- Optimising aliases before accuracy.
- Skipping verification to hit the timer.

## Explain it back

State the control-loop/API reason the solution works, and name the first two observations you would use if it did not.
