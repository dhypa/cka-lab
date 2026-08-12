# Solution — Lab 08: DaemonSets and Controller Self-Healing

This is a **reference path**, not the only valid solution. On CKA, satisfy the requested end state and verify it.

## Intended approach

1. Create DaemonSet manifest based on a generated Pod/Deployment skeleton or docs.
2. Delete one owned Pod and watch reconciliation.
3. Restore node schedulability.

## Canonical commands / evidence

```bash
kubectl get ds -n cka-lab -w
kubectl delete pod -n cka-lab -l app=node-agent --field-selector spec.nodeName=worker01
kubectl get pods -n cka-lab -l app=node-agent -o wide
```

## Expected evidence

- Replacement Pod has a new UID/name.
- DaemonSet desired number matches eligible nodes.

## Common traps

- Trying to `scale` a DaemonSet like a Deployment.
- Forgetting node taints/affinity affect eligibility.

## Explain it back

State the control-loop/API reason the solution works, and name the first two observations you would use if it did not.
