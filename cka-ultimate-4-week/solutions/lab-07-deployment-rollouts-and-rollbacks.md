# Solution — Lab 07: Deployment Rollouts and Rollbacks

This is a **reference path**, not the only valid solution. On CKA, satisfy the requested end state and verify it.

## Intended approach

1. Create Deployment and wait healthy.
2. Use `kubectl set image` for working then broken image.
3. Inspect events/ReplicaSets.
4. Use `kubectl rollout undo`.

## Canonical commands / evidence

```bash
kubectl create deploy rollout-web -n cka-lab --image=nginx:1.27 --replicas=3
kubectl set image deploy/rollout-web -n cka-lab nginx=nginx:1.28
kubectl rollout history deploy/rollout-web -n cka-lab
kubectl set image deploy/rollout-web -n cka-lab nginx=nginx:definitely-not-real
kubectl rollout undo deploy/rollout-web -n cka-lab
```

## Expected evidence

- Healthy old ReplicaSet is scaled back up after undo.
- Deployment image returns to a pullable tag.

## Common traps

- Deleting failing Pods instead of fixing/rolling back the owning Deployment.
- Assuming `kubectl set image` success means rollout success.

## Explain it back

State the control-loop/API reason the solution works, and name the first two observations you would use if it did not.
