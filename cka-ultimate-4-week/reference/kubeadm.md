# kubeadm Runbook

## Know the lifecycle

`kubeadm init` bootstraps the first control plane; a CNI is then installed; `kubeadm join` adds workers or extra control-plane nodes. `kubeadm reset` is destructive local cleanup, not a cluster-wide uninstall.

## Useful inspection

```bash
kubeadm version
kubectl get nodes -o wide
kubectl -n kube-system get pods -o wide
sudo ls /etc/kubernetes/manifests
sudo kubeadm certs check-expiration
```

## Join command

On the control plane:

```bash
kubeadm token create --print-join-command
```

Treat tokens as credentials. Generate a fresh one for practice if the old one expired.

## Upgrade discipline

Use the current upstream kubeadm upgrade page. Do not skip minor versions. Typical control-plane workflow includes package-repository/version checks, upgrading `kubeadm`, `kubeadm upgrade plan`, `kubeadm upgrade apply`, then kubelet/kubectl with node drain/uncordon as appropriate. Worker nodes use `kubeadm upgrade node` rather than `apply`.

Exact package commands and supported skew are version-sensitive: consult the current docs during practice.
