# Solution — Lab 16: Control Plane and Static Pod Anatomy

This is a **reference path**, not the only valid solution. On CKA, satisfy the requested end state and verify it.

## Intended approach

1. Inspect files locally on the control-plane node.
2. Map them to mirror Pods and CRI containers.
3. Use kubelet/CRI evidence for control-plane reasoning.

## Canonical commands / evidence

```bash
ssh controlplane
sudo ls /etc/kubernetes/manifests
kubectl -n kube-system get pods -o wide
sudo crictl ps -a
sudo journalctl -u kubelet --since "10 min ago" --no-pager | tail -50
```

## Expected evidence

- Four common kubeadm static-Pod manifests are visible on a stacked-etcd control plane.
- Node-local runtime/kubelet evidence remains useful when API access is broken.

## Common traps

- Editing live static-Pod files during an anatomy lab.
- Assuming scheduler/controller-manager are systemd services on a normal kubeadm control plane.

## Explain it back

State the control-loop/API reason the solution works, and name the first two observations you would use if it did not.
