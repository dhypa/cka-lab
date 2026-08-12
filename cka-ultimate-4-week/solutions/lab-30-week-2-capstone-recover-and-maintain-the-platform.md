# Solution — Lab 30: Week 2 Capstone: Recover and Maintain the Platform

This is a **reference path**, not the only valid solution. On CKA, satisfy the requested end state and verify it.

## Intended approach

1. Back up before destructive changes.
2. Implement/test RBAC boundaries.
3. Maintain worker one at a time.
4. Operate Helm/Kustomize and verify Kubernetes state.
5. Diagnose one injected fault.
6. Capture handoff evidence.

## Canonical commands / evidence

```bash
kubectl get nodes
kubectl get pods -A
kubeadm token create --print-join-command
helm history maint-web -n cka-helm
sudo kubeadm certs check-expiration
```

## Expected evidence

- All nodes healthy after maintenance.
- Backup and report artifacts exist.
- No broad RBAC grant was used to shortcut the task.

## Common traps

- Doing reset/rejoin before producing a recovery artifact.
- Using cluster-admin to “fix” RBAC.
- Confusing Helm/Kustomize successful render/apply with workload health.

## Explain it back

State the control-loop/API reason the solution works, and name the first two observations you would use if it did not.
