# Lab 24 — Cordon, Drain and Uncordon

**Day:** 12  
**Primary domain:** Cluster Architecture / Scheduling  
**Timebox:** 35–50 min  
**Environment:** Healthy multi-node kubeadm cluster  
**Mode:** Hands-on

## Objective

- Prepare a node for maintenance.
- Understand drain handling of DaemonSets and emptyDir.
- Return the node to normal scheduling and verify rescheduling.

## Scenario

worker01 needs maintenance. You must remove ordinary workloads safely without deleting DaemonSet ownership or leaving the node permanently unschedulable.

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

1. Create Deployment `maintenance-demo` in `cka-lab` with 4 replicas spread as much as practical across workers.
2. Cordon worker01 and prove `spec.unschedulable`/status display.
3. Run a drain dry run if useful, then drain worker01 with appropriate flags for DaemonSets and disposable emptyDir data. Read warnings rather than reflexively adding flags.
4. Prove ordinary workload Pods moved away while DaemonSet behaviour is understood.
5. Uncordon worker01; delete one Deployment Pod elsewhere and observe whether scheduler may use worker01 again.

## Success criteria

- worker01 becomes SchedulingDisabled during maintenance then returns schedulable.
- Owned workload capacity remains available on other nodes if cluster resources allow.
- DaemonSet Pods are not mistakenly treated as standalone Pods.

## Verification

Run these (or an equivalent proof) and explain why each result proves the requirement:

```bash
kubectl get nodes
kubectl get pods -A -o wide --field-selector spec.nodeName=worker01
kubectl get deploy maintenance-demo -n cka-lab
```

## Documentation drill

Without using the solution file, find the relevant upstream documentation for **safe node drain and maintenance**. Locate the exact field/command you would need if the task wording changed. Time the lookup; target **under 2 minutes** by Week 4.

## Failure injection / stretch

1. Create a PodDisruptionBudget and observe how it can block/shape eviction during drain. Restore after understanding it.
2. Compare cordon alone with a `NoSchedule` taint conceptually and via object fields.

## Cleanup / reset

1. Delete the namespace/resources created for this lab unless the next lab reuses them.
2. Return any node labels/taints/configuration changed only for this exercise to the baseline state.
3. Run `kubectl get nodes` and confirm the cluster is healthy.

## Debrief

Answer these in your error log or notes:

1. What does cordon change?
2. Why does drain need special handling for DaemonSets?
3. How can a PDB affect voluntary disruption?

## Solution

Do not open it until you have either completed the lab or spent the full timebox using official documentation: [`../../solutions/lab-24-cordon-drain-and-uncordon.md`](../../solutions/lab-24-cordon-drain-and-uncordon.md).
