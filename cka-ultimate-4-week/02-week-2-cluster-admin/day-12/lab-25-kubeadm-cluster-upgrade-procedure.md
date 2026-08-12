# Lab 25 — kubeadm Cluster Upgrade Procedure

**Day:** 12  
**Primary domain:** Cluster Architecture, Installation & Configuration  
**Timebox:** 90–150 min  
**Environment:** Healthy multi-node kubeadm cluster  
**Mode:** Hands-on

## Objective

- Follow version-aware kubeadm upgrade order.
- Use plan/apply versus node workflow correctly.
- Drain and upgrade nodes without skipping a minor.

## Scenario

You need to move a kubeadm cluster to the next supported minor/patch in a controlled way. Exact package versions are deliberately not hardcoded because repository contents change.

## Prerequisites

- A healthy practice cluster and working `kubectl`.

## Safety / starting-state check

> Version-sensitive and potentially destructive. Snapshot first; only upgrade to a version actually available/supported by the upstream docs and package repository at practice time.

Run and read the output before proceeding:

```bash
hostname
kubectl config current-context
kubectl get nodes -o wide
```

## Lab setup

1. Create any named namespace/resources only when instructed. Do not reuse leftovers from a previous attempt.

## Tasks

1. Take snapshot `30-pre-upgrade`. Read the **current upstream kubeadm upgrade page** for your exact source/target versions and Kubernetes version-skew policy. Do not skip minor versions.
2. On controlplane, inspect available package versions/repositories, upgrade `kubeadm` to the intended supported target, run `kubeadm upgrade plan`, and review all warnings.
3. Perform the documented control-plane `kubeadm upgrade apply` to the target version.
4. Drain controlplane if required by your procedure, upgrade kubelet/kubectl packages, restart kubelet and uncordon.
5. One worker at a time: drain, upgrade kubeadm, run `kubeadm upgrade node`, upgrade kubelet/kubectl, restart and uncordon.
6. Verify node versions, system Pods and workload/network health after each node, not only at the end.

## Success criteria

- No minor version is skipped.
- Control plane upgraded before/appropriately relative to workers according to current docs.
- All nodes end Ready and report intended kubelet versions.
- CNI/DNS/workloads remain healthy.

## Verification

Run these (or an equivalent proof) and explain why each result proves the requirement:

```bash
kubectl get nodes -o wide
kubectl get nodes -o jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.status.nodeInfo.kubeletVersion}{"\n"}{end}'
kubectl get pods -A
kubeadm version
```

## Documentation drill

Without using the solution file, find the relevant upstream documentation for **upgrading kubeadm clusters and Kubernetes version skew policy**. Locate the exact field/command you would need if the task wording changed. Time the lookup; target **under 2 minutes** by Week 4.

## Failure injection / stretch

1. Before changing packages, write the rollback/recovery decision for a failed control-plane upgrade.
2. Explain why blindly running `apt upgrade` on all nodes simultaneously is not an upgrade procedure.

## Cleanup / reset

1. Delete the namespace/resources created for this lab unless the next lab reuses them.
2. Return any node labels/taints/configuration changed only for this exercise to the baseline state.
3. Run `kubectl get nodes` and confirm the cluster is healthy.

## Debrief

Answer these in your error log or notes:

1. Why is kubeadm upgraded before it orchestrates component upgrade?
2. What is different on workers?
3. Which health checks would stop you from proceeding to the next node?

## Solution

Do not open it until you have either completed the lab or spent the full timebox using official documentation: [`../../solutions/lab-25-kubeadm-cluster-upgrade-procedure.md`](../../solutions/lab-25-kubeadm-cluster-upgrade-procedure.md).
