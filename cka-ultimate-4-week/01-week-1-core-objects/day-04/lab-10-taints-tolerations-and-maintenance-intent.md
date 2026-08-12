# Lab 10 — Taints, Tolerations and Maintenance Intent

**Day:** 4  
**Primary domain:** Workloads & Scheduling / Cluster Admin  
**Timebox:** 35–50 min  
**Environment:** Healthy multi-node kubeadm cluster  
**Mode:** Hands-on

## Objective

- Apply and remove taints safely.
- Write matching tolerations.
- Distinguish `NoSchedule`, `PreferNoSchedule`, and `NoExecute`.

## Scenario

A node is reserved for an infrastructure workload. General workloads should not schedule there, while one designated Pod should tolerate the restriction.

## Prerequisites

- A healthy practice cluster and working `kubectl`.

## Safety / starting-state check

> This lab changes node scheduling. Use disposable workloads and remove every practice taint before leaving.

Run and read the output before proceeding:

```bash
hostname
kubectl config current-context
kubectl get nodes -o wide
```

## Lab setup

1. Create any named namespace/resources only when instructed. Do not reuse leftovers from a previous attempt.

## Tasks

1. Taint `worker02` with `dedicated=infra:NoSchedule`.
2. Create Pod `general` with no toleration and enough scheduling freedom that it should run elsewhere.
3. Create Pod `infra` with a matching toleration and nodeSelector pinning it to `worker02`.
4. Prove the taint and placement.
5. Change/research effect to `NoExecute` in a disposable follow-up: create a normal Pod on worker02 first, then apply `NoExecute` with no toleration and observe eviction. Restore the node after evidence.

## Success criteria

- Taint is visible on worker02.
- Only appropriately constrained/tolerating workload is allowed onto the tainted node.
- Node ends with practice taints removed.

## Verification

Run these (or an equivalent proof) and explain why each result proves the requirement:

```bash
kubectl describe node worker02 | grep -A2 Taints
kubectl get po -n cka-schedule -o wide
kubectl get nodes
```

## Documentation drill

Without using the solution file, find the relevant upstream documentation for **taints and tolerations**. Locate the exact field/command you would need if the task wording changed. Time the lookup; target **under 2 minutes** by Week 4.

## Failure injection / stretch

1. Add a toleration with `tolerationSeconds` for a `NoExecute` taint and observe delayed eviction semantics.
2. Explain why a toleration permits scheduling but does not itself force a Pod onto that node.

## Cleanup / reset

1. Delete the namespace/resources created for this lab unless the next lab reuses them.
2. Return any node labels/taints/configuration changed only for this exercise to the baseline state.
3. Run `kubectl get nodes` and confirm the cluster is healthy.

## Debrief

Answer these in your error log or notes:

1. Why does a toleration not guarantee placement on the tainted node?
2. Which taint effect can evict existing Pods?
3. How is `kubectl drain` different from manually applying a taint?

## Solution

Do not open it until you have either completed the lab or spent the full timebox using official documentation: [`../../solutions/lab-10-taints-tolerations-and-maintenance-intent.md`](../../solutions/lab-10-taints-tolerations-and-maintenance-intent.md).
