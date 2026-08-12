# Lab 07 — Deployment Rollouts and Rollbacks

**Day:** 3  
**Primary domain:** Workloads & Scheduling  
**Timebox:** 35–50 min  
**Environment:** Healthy multi-node kubeadm cluster  
**Mode:** Hands-on

## Objective

- Perform rolling image updates.
- Inspect rollout status/history and pause on failure.
- Rollback to a known-good revision.

## Scenario

A production Deployment must move to a new image, but the proposed tag is broken. You need to recognise the stalled rollout and restore service quickly.

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

1. Create Deployment `rollout-web` with 3 replicas of `nginx:1.27` in `cka-lab` and annotate the change cause.
2. Update to `nginx:1.28` (or another pullable newer nginx tag available in your environment), wait for successful rollout and inspect history.
3. Update to `nginx:definitely-not-real`; inspect rollout, new ReplicaSet and events without deleting the Deployment.
4. Rollback to the previous working revision.
5. Prove three ready replicas serve the working image and record rollout history.

## Success criteria

- A failed image update is visible in ReplicaSet/Pod evidence.
- Rollback restores three Available replicas.
- You can identify which revision is healthy.

## Verification

Run these (or an equivalent proof) and explain why each result proves the requirement:

```bash
kubectl rollout status deploy/rollout-web -n cka-lab --timeout=90s
kubectl rollout history deploy/rollout-web -n cka-lab
kubectl get rs,pod -n cka-lab -l app=rollout-web -o wide
kubectl get deploy rollout-web -n cka-lab -o jsonpath='{.spec.template.spec.containers[0].image}{"\n"}'
```

## Documentation drill

Without using the solution file, find the relevant upstream documentation for **Deployments: rolling update, rollout history, rollback**. Locate the exact field/command you would need if the task wording changed. Time the lookup; target **under 2 minutes** by Week 4.

## Failure injection / stretch

1. Set `maxUnavailable: 0` and `maxSurge: 1`; explain how that changes rollout capacity.
2. Pause a Deployment, make two template changes, resume it, and observe revision behaviour.

## Cleanup / reset

1. Delete the namespace/resources created for this lab unless the next lab reuses them.
2. Return any node labels/taints/configuration changed only for this exercise to the baseline state.
3. Run `kubectl get nodes` and confirm the cluster is healthy.

## Debrief

Answer these in your error log or notes:

1. Why does deleting a bad Pod not fix a bad Deployment template?
2. Which controller objects preserve rollout revisions?
3. What evidence tells you rollback has actually completed?

## Solution

Do not open it until you have either completed the lab or spent the full timebox using official documentation: [`../../solutions/lab-07-deployment-rollouts-and-rollbacks.md`](../../solutions/lab-07-deployment-rollouts-and-rollbacks.md).
