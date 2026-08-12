# Solution — Lab 10: Taints, Tolerations and Maintenance Intent

This is a **reference path**, not the only valid solution. On CKA, satisfy the requested end state and verify it.

## Intended approach

1. Apply taint with `kubectl taint`.
2. Create one normal and one matching Pod.
3. Observe `NoExecute` only in a safe disposable experiment.
4. Remove taints with trailing `-`.

## Canonical commands / evidence

```bash
kubectl taint node worker02 dedicated=infra:NoSchedule
kubectl describe node worker02 | grep Taints
kubectl taint node worker02 dedicated=infra:NoSchedule-
```

## Expected evidence

- Taint acts on nodes; toleration appears in Pod spec.
- Matching toleration removes a scheduling rejection but placement still depends on all other scheduler rules.

## Common traps

- Thinking toleration equals node affinity.
- Forgetting a `NoExecute` experiment can evict existing Pods.

## Explain it back

State the control-loop/API reason the solution works, and name the first two observations you would use if it did not.
