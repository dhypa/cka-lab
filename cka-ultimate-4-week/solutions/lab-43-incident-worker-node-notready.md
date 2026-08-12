# Solution — Lab 43: Incident: Worker Node NotReady

This is a **reference path**, not the only valid solution. On CKA, satisfy the requested end state and verify it.

## Intended approach

1. Observe from API first.
2. Inspect node conditions/events and workload impact.
3. Use node-local service/journal evidence.
4. Restore failed service and verify heartbeat/workload.

## Canonical commands / evidence

```bash
kubectl describe node worker02
ssh worker02 "sudo systemctl status kubelet --no-pager; sudo journalctl -u kubelet --since '15 min ago' --no-pager | tail -80"
ssh worker02 sudo systemctl start kubelet
kubectl get node worker02 -w
```

## Expected evidence

- Ready condition recovers after kubelet resumes healthy operation.
- Service-state evidence identifies local cause.

## Common traps

- Rebooting the VM immediately and losing diagnostic evidence.
- Restarting containerd/kubelet blindly without checking which one failed.

## Explain it back

State the control-loop/API reason the solution works, and name the first two observations you would use if it did not.
