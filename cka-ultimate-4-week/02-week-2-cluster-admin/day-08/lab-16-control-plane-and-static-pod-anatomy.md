# Lab 16 — Control Plane and Static Pod Anatomy

**Day:** 8  
**Primary domain:** Cluster Architecture / Troubleshooting  
**Timebox:** 35–50 min  
**Environment:** kubeadm control-plane node with SSH access  
**Mode:** Hands-on

## Objective

- Identify API server, scheduler, controller-manager, etcd, kubelet and proxy responsibilities.
- Inspect kubeadm static Pod manifests and their running containers.
- Map a manifest-file change to kubelet reconciliation.

## Scenario

Before repairing a control-plane outage, you need to know which components are static Pods, where kubelet gets their desired state, and which logs remain available if the Kubernetes API itself is unhealthy.

## Prerequisites

- A healthy practice cluster and working `kubectl`.

## Safety / starting-state check

> Non-destructive unless a task says otherwise. Confirm host/context before making changes.

Run and read the output before proceeding:

```bash
hostname
kubectl config current-context
kubectl get nodes -o wide
```

## Lab setup

1. Create any named namespace/resources only when instructed. Do not reuse leftovers from a previous attempt.

## Tasks

1. SSH to `controlplane` and inventory `/etc/kubernetes/manifests` without modifying it.
2. For each static Pod manifest, record component name, image, hostNetwork use, important hostPath volumes and one notable command flag.
3. Compare manifest filenames with Pods visible in `kube-system` and inspect `ownerReferences`/annotations that identify mirror Pods.
4. Use the CRI tooling available on the node (`crictl` where configured) to find the API server container and read recent logs.
5. Explain what kubelet would do if a static Pod manifest were renamed out of the manifest directory. Do not perform the destructive action yet.

## Success criteria

- You can locate each control-plane static Pod manifest from memory.
- You can obtain component logs without depending solely on `kubectl logs`.
- You can explain the kubelet/static-Pod/mirror-Pod relationship.

## Verification

Run these (or an equivalent proof) and explain why each result proves the requirement:

```bash
sudo ls -l /etc/kubernetes/manifests
kubectl -n kube-system get pods -o wide | grep controlplane
sudo crictl ps 2>/dev/null | head || true
```

## Documentation drill

Without using the solution file, find the relevant upstream documentation for **static Pods, Kubernetes components, and kubeadm implementation details**. Locate the exact field/command you would need if the task wording changed. Time the lookup; target **under 2 minutes** by Week 4.

## Failure injection / stretch

1. Copy one manifest to `/tmp`, identify certificate/key mounts and trace one host file into the container.
2. Stop short of changing a live manifest: write exactly how you would restore the API server if an invalid flag prevented it from starting.

## Cleanup / reset

1. Delete the namespace/resources created for this lab unless the next lab reuses them.
2. Return any node labels/taints/configuration changed only for this exercise to the baseline state.
3. Run `kubectl get nodes` and confirm the cluster is healthy.

## Debrief

Answer these in your error log or notes:

1. Which component makes placement decisions?
2. Which component runs Pods on a node?
3. Why can `kubectl logs` be unavailable precisely when CRI logs are most useful?

## Solution

Do not open it until you have either completed the lab or spent the full timebox using official documentation: [`../../solutions/lab-16-control-plane-and-static-pod-anatomy.md`](../../solutions/lab-16-control-plane-and-static-pod-anatomy.md).
