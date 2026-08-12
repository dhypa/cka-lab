# Linux / Node Debugging Reference

## Scope first

```bash
hostname
kubectl get node NODE
kubectl describe node NODE
```

## Services

```bash
sudo systemctl status kubelet --no-pager
sudo systemctl status containerd --no-pager
sudo journalctl -u kubelet --since '15 min ago' --no-pager
sudo journalctl -u containerd --since '15 min ago' --no-pager
```

Do not restart both services before reading them; you may destroy the distinction between cause and symptom.

## Runtime

```bash
sudo crictl info
sudo crictl ps -a
sudo crictl pods
```

If `crictl` needs an endpoint/configuration in your environment, inspect kubelet/runtime settings rather than guessing.

## Capacity / pressure

```bash
df -h
df -i
free -h
ps aux --sort=-%mem | head
sudo du -xh /var/lib/containerd /var/lib/kubelet 2>/dev/null | sort -h | tail
```

Correlate with Node Conditions such as MemoryPressure, DiskPressure and PIDPressure.

## Networking evidence

```bash
ip addr
ip route
sudo ss -lntup
sudo ls -l /etc/cni/net.d 2>/dev/null || true
```

## kubeadm control-plane local evidence

```bash
sudo ls -l /etc/kubernetes/manifests
sudo crictl ps -a
sudo journalctl -u kubelet --since '15 min ago' --no-pager
```

If the API is down, this node-local evidence is often the path to recovery.
