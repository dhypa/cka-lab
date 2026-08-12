# Solution — Lab 18: Worker Join, Reset and Rejoin

This is a **reference path**, not the only valid solution. On CKA, satisfy the requested end state and verify it.

## Intended approach

1. Drain/delete Node object.
2. Reset the target worker only.
3. Generate fresh join command and execute it on worker.
4. Verify node/CNI/kubelet and schedule a Pod.

## Canonical commands / evidence

```bash
kubectl drain worker02 --ignore-daemonsets --delete-emptydir-data
kubectl delete node worker02
ssh worker02 sudo kubeadm reset -f
kubeadm token create --print-join-command
kubectl get node worker02 -w
```

## Expected evidence

- Rejoined node has a new registration lifecycle and reaches Ready.
- kubelet on worker02 is active.

## Common traps

- Running `kubeadm reset` on controlplane by accident.
- Expecting reset to remove every CNI/interface/firewall artifact automatically.

## Explain it back

State the control-loop/API reason the solution works, and name the first two observations you would use if it did not.
