# Lab 49 — Timed Cluster Administration Circuit

**Day:** 23  
**Primary domain:** Cluster Admin / Troubleshooting  
**Timebox:** 45 min  
**Environment:** Healthy multi-node kubeadm cluster  
**Mode:** Timed circuit

## Objective

- Perform common admin operations within a strict timebox.
- Balance destructive-task safety with speed.
- Use authorization/node/control-plane evidence efficiently.

## Scenario

This 45-minute circuit compresses RBAC, node maintenance, kubeadm evidence and backup thinking.

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

1. Preflight host/context. Create namespace `cka-admin-speed`, ServiceAccount `ops`, and permissions: read Pods in namespace, list Nodes cluster-wide. Prove positive and negative actions.
2. On worker02, record kubelet and containerd active state plus kubelet version into `/tmp/worker02-health.txt` **on worker02**.
3. Cordon worker02, inspect workloads, then uncordon. Do not drain shared workloads unless safe.
4. On controlplane, generate a fresh worker join command and save it to `/tmp/join.sh` with owner-only permissions; do not execute it.
5. Run `kubeadm certs check-expiration` and save output.
6. Inspect etcd manifest and write the endpoint + TLS certificate paths you would use for snapshot into `/tmp/etcd-inputs.txt`; if your snapshot command is rehearsed/tooling available, also create a verified snapshot.
7. Return cluster exactly healthy/schedulable.

## Success criteria

- RBAC boundaries verified.
- worker02 remains Ready/schedulable.
- Join file is generated securely.
- Certificate and etcd input files exist on intended host.

## Verification

Run these (or an equivalent proof) and explain why each result proves the requirement:

```bash
kubectl get nodes
kubectl auth can-i list nodes --as=system:serviceaccount:cka-admin-speed:ops
ssh worker02 cat /tmp/worker02-health.txt
ssh controlplane "ls -l /tmp/join.sh /tmp/etcd-inputs.txt"
```

## Documentation drill

Without using the solution file, find the relevant upstream documentation for **RBAC, node maintenance, kubeadm join and etcd backup docs**. Locate the exact field/command you would need if the task wording changed. Time the lookup; target **under 2 minutes** by Week 4.

## Failure injection / stretch

1. Repeat with 35-minute cap.
2. Add a stopped-kubelet fault on worker02 and include diagnose/restore within timer after snapshot.

## Cleanup / reset

1. Delete the namespace/resources created for this lab unless the next lab reuses them.
2. Return any node labels/taints/configuration changed only for this exercise to the baseline state.
3. Run `kubectl get nodes` and confirm the cluster is healthy.

## Debrief

Answer these in your error log or notes:

1. Which admin sequence is still not automatic?
2. Did safety checks materially slow you, or prevent errors?
3. What would you skip first if this were one task among 17?

## Solution

Do not open it until you have either completed the lab or spent the full timebox using official documentation: [`../../solutions/lab-49-timed-cluster-administration-circuit.md`](../../solutions/lab-49-timed-cluster-administration-circuit.md).
