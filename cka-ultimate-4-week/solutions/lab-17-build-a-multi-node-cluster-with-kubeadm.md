# Solution — Lab 17: Build a Multi-Node Cluster with kubeadm

This is a **reference path**, not the only valid solution. On CKA, satisfy the requested end state and verify it.

## Intended approach

1. Initialise first control plane.
2. Configure kubeconfig.
3. Install compatible CNI.
4. Join workers with token/hash command.
5. Verify nodes, system Pods and actual network traffic.

## Canonical commands / evidence

```bash
sudo kubeadm init <CNI-APPROPRIATE-OPTIONS>
mkdir -p $HOME/.kube && sudo cp /etc/kubernetes/admin.conf $HOME/.kube/config && sudo chown $(id -u):$(id -g) $HOME/.kube/config
kubeadm token create --print-join-command
kubectl get nodes
kubectl get pods -A
```

## Expected evidence

- The API is reachable and workers register.
- CNI makes nodes Ready/Pod networking functional.

## Common traps

- Using a Pod CIDR incompatible with the selected CNI configuration.
- Joining workers before carefully reading a failed init/join error.
- Treating Ready nodes as sufficient without testing DNS/Pod networking.

## Explain it back

State the control-loop/API reason the solution works, and name the first two observations you would use if it did not.
