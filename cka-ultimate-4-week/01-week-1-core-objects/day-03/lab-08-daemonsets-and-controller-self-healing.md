# Lab 08 — DaemonSets and Controller Self-Healing

**Day:** 3  
**Primary domain:** Workloads & Scheduling  
**Timebox:** 35–50 min  
**Environment:** Healthy multi-node kubeadm cluster  
**Mode:** Hands-on

## Objective

- Create/inspect a DaemonSet.
- Observe controller self-healing after Pod deletion.
- Understand DaemonSet interactions with node scheduling.

## Scenario

You need a node-local agent on every worker. Unlike a Deployment, replica count should follow eligible nodes.

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

1. Create DaemonSet `node-agent` in `cka-lab` using `busybox:1.36` running `sh -c "echo $(hostname); sleep 36000"`.
2. Constrain it to Linux nodes and, if needed, exclude the control plane so exactly one Pod runs per worker.
3. Record Pod names and node placement. Delete one DaemonSet Pod and prove the controller replaces it on the same eligible node set.
4. Cordon `worker02`; explain/observe whether the already-running DaemonSet Pod disappears. Uncordon afterwards.

## Success criteria

- One DaemonSet Pod runs per intended eligible worker.
- Deleting a Pod creates a replacement without editing desired count.
- Cluster ends with all nodes schedulable as before.

## Verification

Run these (or an equivalent proof) and explain why each result proves the requirement:

```bash
kubectl get ds node-agent -n cka-lab
kubectl get po -n cka-lab -l app=node-agent -o wide
kubectl get nodes
```

## Documentation drill

Without using the solution file, find the relevant upstream documentation for **DaemonSets and controller self-healing**. Locate the exact field/command you would need if the task wording changed. Time the lookup; target **under 2 minutes** by Week 4.

## Failure injection / stretch

1. Add a toleration that would allow placement on a tainted node and explain why node agents often need broader tolerations.
2. Compare DaemonSet desired/current/ready counts before and after temporarily adding an eligibility label to a node.

## Cleanup / reset

1. Delete the namespace/resources created for this lab unless the next lab reuses them.
2. Return any node labels/taints/configuration changed only for this exercise to the baseline state.
3. Run `kubectl get nodes` and confirm the cluster is healthy.

## Debrief

Answer these in your error log or notes:

1. What determines DaemonSet desired Pod count?
2. Why does controller ownership matter when deleting Pods?
3. Why are log/monitoring agents commonly DaemonSets?

## Solution

Do not open it until you have either completed the lab or spent the full timebox using official documentation: [`../../solutions/lab-08-daemonsets-and-controller-self-healing.md`](../../solutions/lab-08-daemonsets-and-controller-self-healing.md).
