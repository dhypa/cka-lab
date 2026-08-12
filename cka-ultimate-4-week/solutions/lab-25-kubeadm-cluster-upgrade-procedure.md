# Solution — Lab 25: kubeadm Cluster Upgrade Procedure

This is a **reference path**, not the only valid solution. On CKA, satisfy the requested end state and verify it.

## Intended approach

1. Resolve exact source/target and docs first.
2. Upgrade kubeadm/control-plane in documented order.
3. Drain and upgrade kubelet/kubectl.
4. Repeat worker-by-worker using `kubeadm upgrade node`.
5. Verify after each stage.

## Canonical commands / evidence

```bash
kubeadm version
sudo kubeadm upgrade plan
kubectl get nodes -o wide
kubectl get pods -A
```

## Expected evidence

- Target versions align within supported skew.
- Cluster health survives maintenance one node at a time.

## Common traps

- Copying package/version commands from this course instead of current docs.
- Skipping a minor version.
- Running `kubeadm upgrade apply` on every worker instead of the node-specific workflow.

## Explain it back

State the control-loop/API reason the solution works, and name the first two observations you would use if it did not.
