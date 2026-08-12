# Solution — Lab 22: etcd Snapshot and Restore

This is a **reference path**, not the only valid solution. On CKA, satisfy the requested end state and verify it.

## Intended approach

1. Read TLS/data paths from the live etcd static Pod manifest.
2. Use the version-appropriate etcd snapshot command; verify the result.
3. Restore into a separate directory rather than overwriting live data in place.
4. Point static Pod at restored directory and verify API/objects.

## Canonical commands / evidence

```bash
sudo grep -nE "listen-client|cert-file|key-file|trusted-ca|data-dir" /etc/kubernetes/manifests/etcd.yaml
sudo mkdir -p /var/backups
sudo ls -lh /var/backups/cka-etcd.db
kubectl get --raw=/readyz?verbose
```

## Expected evidence

- Verified snapshot exists before any restore attempt.
- Cluster recovers and post-snapshot marker is absent after restore.

## Common traps

- Copying certificate paths from an old tutorial instead of inspecting this cluster.
- Restoring directly over active etcd data.
- Forgetting that changing etcd state rewinds Kubernetes objects cluster-wide.

## Explain it back

State the control-loop/API reason the solution works, and name the first two observations you would use if it did not.
