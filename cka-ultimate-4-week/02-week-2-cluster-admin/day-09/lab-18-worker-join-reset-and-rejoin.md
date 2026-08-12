# Lab 18 — Worker Join, Reset and Rejoin

**Day:** 9  
**Primary domain:** Cluster Architecture, Installation & Configuration  
**Timebox:** 35–50 min  
**Environment:** Healthy multi-node kubeadm cluster  
**Mode:** Hands-on

## Objective

- Generate a fresh worker join command.
- Remove and reset a worker deliberately.
- Diagnose/rejoin without rebuilding the whole cluster.

## Scenario

A worker VM has been repurposed and must be cleanly removed then returned to the cluster. The control plane must remain available throughout.

## Prerequisites

- A healthy practice cluster and working `kubectl`.

## Safety / starting-state check

> Destructive on worker02. Verify hostname in both shells before `kubeadm reset`.

Run and read the output before proceeding:

```bash
hostname
kubectl config current-context
kubectl get nodes -o wide
```

## Lab setup

1. Create any named namespace/resources only when instructed. Do not reuse leftovers from a previous attempt.

## Tasks

1. From controlplane, drain `worker02` safely for disposable lab workloads, then delete the Node object.
2. On worker02, run `kubeadm reset` after inspecting what it will affect. Inspect remaining CNI/network files rather than assuming every trace is removed.
3. On controlplane, generate a fresh join command using `kubeadm token create --print-join-command`.
4. Rejoin worker02 and watch node conditions transition to Ready.
5. Schedule a test Pod specifically to worker02 using a temporary label/selector and verify it starts. Remove the label afterwards.

## Success criteria

- worker02 disappears then rejoins with Ready status.
- No unnecessary control-plane reset occurs.
- A workload successfully runs on the rejoined node.

## Verification

Run these (or an equivalent proof) and explain why each result proves the requirement:

```bash
kubectl get node worker02 -o wide
ssh worker02 sudo systemctl is-active kubelet
kubectl get pods -A -o wide --field-selector spec.nodeName=worker02
```

## Documentation drill

Without using the solution file, find the relevant upstream documentation for **kubeadm join, tokens, and kubeadm reset**. Locate the exact field/command you would need if the task wording changed. Time the lookup; target **under 2 minutes** by Week 4.

## Failure injection / stretch

1. Let a token expire or delete it, attempt the old join command, and diagnose the discovery failure before creating a new token.
2. Compare node UID before deletion and after rejoin.

## Cleanup / reset

1. Delete the namespace/resources created for this lab unless the next lab reuses them.
2. Return any node labels/taints/configuration changed only for this exercise to the baseline state.
3. Run `kubectl get nodes` and confirm the cluster is healthy.

## Debrief

Answer these in your error log or notes:

1. What state is cluster-scoped versus local to the joining node?
2. Why might CNI cleanup still matter after reset?
3. How do you create a fresh join command quickly?

## Solution

Do not open it until you have either completed the lab or spent the full timebox using official documentation: [`../../solutions/lab-18-worker-join-reset-and-rejoin.md`](../../solutions/lab-18-worker-join-reset-and-rejoin.md).
