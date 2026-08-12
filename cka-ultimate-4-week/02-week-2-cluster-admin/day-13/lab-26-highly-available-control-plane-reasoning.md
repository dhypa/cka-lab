# Lab 26 — Highly Available Control Plane Reasoning

**Day:** 13  
**Primary domain:** Cluster Architecture, Installation & Configuration  
**Timebox:** 35–50 min  
**Environment:** Healthy multi-node kubeadm cluster  
**Mode:** Architecture + optional live lab

## Objective

- Explain HA control-plane topology and stable API endpoint.
- Distinguish stacked and external etcd trade-offs.
- Read kubeadm configuration for controlPlaneEndpoint.

## Scenario

The competency expects you to manage/understand a highly available control plane. Building three extra VMs is optional, but you must be able to reason about how kubeadm joins additional control-plane nodes and why clients need a stable endpoint.

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

1. Draw a topology with 3 control-plane nodes, load balancer/VIP API endpoint, workers, and either stacked etcd or external etcd.
2. Inspect your current kubeadm cluster configuration and identify whether `controlPlaneEndpoint` is set.
3. Use current kubeadm HA documentation to list prerequisites for joining another control-plane node, including certificate-key/upload-certs concerns and join flags.
4. Explain quorum for a 3-member etcd cluster and why two simultaneous member losses are fatal to quorum.
5. Optional live branch: provision `controlplane02`/`03`, add a TCP load-balancing endpoint, and join them using official HA instructions. Verify API remains reachable when one control-plane VM is stopped.

## Success criteria

- You can explain the purpose of a stable controlPlaneEndpoint.
- You can compare stacked versus external etcd.
- You know the difference between a worker join and `--control-plane` join.

## Verification

Run these (or an equivalent proof) and explain why each result proves the requirement:

```bash
kubectl -n kube-system get cm kubeadm-config -o yaml
kubectl cluster-info
kubectl get nodes -o wide
```

## Documentation drill

Without using the solution file, find the relevant upstream documentation for **creating highly available clusters with kubeadm**. Locate the exact field/command you would need if the task wording changed. Time the lookup; target **under 2 minutes** by Week 4.

## Failure injection / stretch

1. Calculate quorum for 1, 3, and 5 etcd members and state tolerated failures.
2. If using only one control plane, explain why a LoadBalancer object inside the same broken cluster is not automatically a robust external API endpoint.

## Cleanup / reset

1. Delete the namespace/resources created for this lab unless the next lab reuses them.
2. Return any node labels/taints/configuration changed only for this exercise to the baseline state.
3. Run `kubectl get nodes` and confirm the cluster is healthy.

## Debrief

Answer these in your error log or notes:

1. Why do clients need a stable API endpoint?
2. What failure does three API servers not solve if stacked etcd has lost quorum?
3. What extra concerns exist for control-plane join compared with worker join?

## Solution

Do not open it until you have either completed the lab or spent the full timebox using official documentation: [`../../solutions/lab-26-highly-available-control-plane-reasoning.md`](../../solutions/lab-26-highly-available-control-plane-reasoning.md).
