# Lab 09 — nodeSelector and Node Affinity

**Day:** 4  
**Primary domain:** Workloads & Scheduling  
**Timebox:** 35–50 min  
**Environment:** Healthy multi-node kubeadm cluster  
**Mode:** Hands-on

## Objective

- Place Pods using node labels and nodeSelector.
- Use required node affinity for equivalent/more expressive scheduling.
- Diagnose Pending due to unsatisfied placement constraints.

## Scenario

A workload requires SSD-capable nodes. You must constrain it deliberately and explain scheduler evidence when no matching node exists.

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

1. Label `worker01` with `disk=ssd` and `worker02` with `disk=hdd`.
2. Create Pod `ssd-pod` in namespace `cka-schedule` with nodeSelector `disk=ssd`; prove it lands on `worker01`.
3. Create Pod `nvme-pod` requiring label `disk=nvme`; inspect Pending events. Do not “fix” it by setting `nodeName`.
4. Replace nodeSelector with required node affinity permitting either `ssd` or `nvme`; schedule a new Pod and inspect chosen node.
5. Remove practice labels during cleanup.

## Success criteria

- `ssd-pod` is scheduled to worker01.
- Pending event for impossible constraint names scheduler/affinity mismatch.
- Affinity Pod schedules only to matching label values.

## Verification

Run these (or an equivalent proof) and explain why each result proves the requirement:

```bash
kubectl get po -n cka-schedule -o wide
kubectl describe pod nvme-pod -n cka-schedule | tail -30
kubectl get nodes --show-labels | grep -E 'worker01|worker02'
```

## Documentation drill

Without using the solution file, find the relevant upstream documentation for **assign Pods to nodes: nodeSelector and node affinity**. Locate the exact field/command you would need if the task wording changed. Time the lookup; target **under 2 minutes** by Week 4.

## Failure injection / stretch

1. Create a preferred affinity for `disk=ssd` rather than required; predict where it can land if worker01 is unavailable.
2. Compare `nodeName` bypass semantics with scheduler constraints and explain why it is usually the wrong answer to a scheduling-policy task.

## Cleanup / reset

1. Delete the namespace/resources created for this lab unless the next lab reuses them.
2. Return any node labels/taints/configuration changed only for this exercise to the baseline state.
3. Run `kubectl get nodes` and confirm the cluster is healthy.

## Debrief

Answer these in your error log or notes:

1. What is more expressive: nodeSelector or node affinity?
2. Does `IgnoredDuringExecution` evict a running Pod when labels change?
3. Where do you look first for why a Pod is Pending?

## Solution

Do not open it until you have either completed the lab or spent the full timebox using official documentation: [`../../solutions/lab-09-nodeselector-and-node-affinity.md`](../../solutions/lab-09-nodeselector-and-node-affinity.md).
