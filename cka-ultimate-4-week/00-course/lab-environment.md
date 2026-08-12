# Lab Environment

## Recommended topology

Use disposable Linux VMs so that control-plane and node failures are real:

| VM | Suggested resources | Purpose |
|---|---|---|
| `controlplane` | 2 vCPU, 4 GB RAM, 30 GB | kubeadm control plane + etcd |
| `worker01` | 2 vCPU, 3–4 GB RAM, 30 GB | workload node |
| `worker02` | 2 vCPU, 3–4 GB RAM, 30 GB | workload/failure node |
| `cka-shell` (optional) | 1–2 vCPU, 2 GB RAM | exam-like jump/task shell |

Ubuntu Server or another kubeadm-supported Linux distribution is fine. The course assumes `systemd` commands in node troubleshooting labs.

## Kubernetes version

Build against the current exam minor when practical. This course targets **1.35**. Keep all Kubernetes packages on the same minor unless a lab explicitly performs an upgrade.

Use the upstream installation documentation rather than blindly copying old repository instructions. For Debian-family systems, the per-minor package repository is under `pkgs.k8s.io` (for this build, the stable v1.35 repo).

## Runtime and CNI

- Use a CRI runtime such as containerd.
- Install one mainstream CNI plugin.
- For NetworkPolicy labs, the chosen CNI must actually enforce NetworkPolicy. A policy object alone does not guarantee enforcement.
- Metrics Server is useful for HPA/resource labs. Install it only after the base cluster works.
- Ingress and Gateway API require controllers/CRDs to produce a live data plane. Syntax/status labs can still be done without exposing internet traffic.

## Snapshots

Create hypervisor snapshots before destructive checkpoints:

- `00-clean-os` — packages/runtime installed, Kubernetes not initialised.
- `10-cluster-ready` — three-node healthy cluster, CNI working.
- `30-pre-upgrade` — healthy state immediately before upgrade/destructive control-plane work.

Never make snapshot restore your only repair technique: first diagnose the fault, then restore if needed for repeatability.

## Cluster baseline

A healthy starting point should look roughly like:

```bash
kubectl get nodes
kubectl get pods -A
kubectl cluster-info
```

All nodes should be `Ready`, control-plane Pods healthy, and DNS running. Save a fresh snapshot.

## Exam-like shell habits

Put these in your interactive shell if they are not already present:

```bash
alias k=kubectl
source <(kubectl completion bash)
complete -o default -F __start_kubectl k
export KUBE_EDITOR=vim   # or nano if that is genuinely faster for you
```

Do not depend on elaborate personal aliases. The real exam environment has a small known toolset; practise commands you can reconstruct quickly.

## Pre-destructive-lab checklist

```bash
hostname
kubectl config current-context
kubectl get nodes
sudo systemctl is-active kubelet
sudo systemctl is-active containerd
```

Take the requested snapshot before etcd restore, static-Pod breakage, kubelet failure, kubeadm reset, or cluster upgrade labs.
