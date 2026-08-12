# Solution — Lab 49: Timed Cluster Administration Circuit

This is a **reference path**, not the only valid solution. On CKA, satisfy the requested end state and verify it.

## Intended approach

1. Create/test least privilege.
2. Collect node-local evidence on correct host.
3. Cordon/uncordon safely.
4. Generate join and cert/etcd data on controlplane.

## Canonical commands / evidence

```bash
kubeadm token create --print-join-command
sudo kubeadm certs check-expiration
kubectl get nodes
```

## Expected evidence

- All evidence files are on requested hosts.
- No node remains cordoned.

## Common traps

- Creating a broad ClusterRole to save time.
- Leaving token file world-readable.
- Forgetting current SSH host.

## Explain it back

State the control-loop/API reason the solution works, and name the first two observations you would use if it did not.
