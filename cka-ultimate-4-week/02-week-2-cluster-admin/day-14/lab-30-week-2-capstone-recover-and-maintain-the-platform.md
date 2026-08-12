# Lab 30 — Week 2 Capstone: Recover and Maintain the Platform

**Day:** 14  
**Primary domain:** Cluster Admin / Troubleshooting  
**Timebox:** 120–150 min  
**Environment:** Healthy multi-node kubeadm cluster  
**Mode:** Capstone

## Objective

- Combine node, RBAC, backup, maintenance, package-management and extension-tool skills.
- Perform high-risk work using checkpoints and verification.
- Produce an administrator handoff record.

## Scenario

You inherit a kubeadm cluster before a maintenance window. Several controls are wrong, a worker needs lifecycle work, and you need a tested recovery artifact before changing anything.

## Prerequisites

- A healthy practice cluster and working `kubectl`.

## Safety / starting-state check

> Contains destructive worker maintenance. Snapshot worker02 and verify hostname before reset/stop commands.

Run and read the output before proceeding:

```bash
hostname
kubectl config current-context
kubectl get nodes -o wide
```

## Lab setup

1. Create any named namespace/resources only when instructed. Do not reuse leftovers from a previous attempt.

## Tasks

1. Take/verify an etcd snapshot and record its path/checksum/status evidence.
2. Create ServiceAccount `maint-reader` in `cka-rbac` that may list Nodes cluster-wide and read Pods only in `cka-rbac`; prove negative permissions.
3. Cordon/drain worker02, reset and rejoin it using a fresh join command; return it Ready and schedulable.
4. Deploy the local Helm chart as release `maint-web` with 3 replicas, then change one value through an upgrade and verify history.
5. Deploy one Kustomize overlay and prove the rendered/live transformation.
6. Inject one safe failure: stop kubelet on worker02 **or** break a disposable workload selector. Diagnose it from evidence and restore.
7. Run certificate-expiry inventory and save it.
8. Write `/tmp/week2-handoff.txt` with: snapshot path, node statuses/versions, RBAC positive+negative results, Helm current revision, and certificate-expiry command used.

## Success criteria

- etcd backup evidence exists before destructive maintenance.
- worker02 returns Ready and schedulable.
- Least-privilege RBAC tests pass/fail exactly as intended.
- Helm/Kustomize resources are healthy.
- Handoff file is generated from observed state.

## Verification

Run these (or an equivalent proof) and explain why each result proves the requirement:

```bash
kubectl get nodes -o wide
kubectl auth can-i list nodes --as=system:serviceaccount:cka-rbac:maint-reader
helm list -A
sudo kubeadm certs check-expiration | head
cat /tmp/week2-handoff.txt
```

## Documentation drill

Without using the solution file, find the relevant upstream documentation for **Choose current docs for the operation you are least confident in: etcd, kubeadm join/reset, RBAC, Helm or Kustomize**. Locate the exact field/command you would need if the task wording changed. Time the lookup; target **under 2 minutes** by Week 4.

## Failure injection / stretch

1. Repeat the worker lifecycle portion with a 20-minute timebox from a known snapshot.
2. Ask yourself which single mistaken hostname/context check could have made the capstone catastrophic and add a guardrail to your routine.

## Cleanup / reset

1. Delete the namespace/resources created for this lab unless the next lab reuses them.
2. Return any node labels/taints/configuration changed only for this exercise to the baseline state.
3. Run `kubectl get nodes` and confirm the cluster is healthy.

## Debrief

Answer these in your error log or notes:

1. Which maintenance step had the largest blast radius and how did you control it?
2. What piece of evidence would you hand another administrator first?
3. Which Week 2 skill remains slow enough to threaten exam timing?

## Solution

Do not open it until you have either completed the lab or spent the full timebox using official documentation: [`../../solutions/lab-30-week-2-capstone-recover-and-maintain-the-platform.md`](../../solutions/lab-30-week-2-capstone-recover-and-maintain-the-platform.md).
