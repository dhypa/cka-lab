# Lab 28 — Helm Install, Upgrade and Rollback

**Day:** 13  
**Primary domain:** Cluster Architecture, Installation & Configuration  
**Timebox:** 35–50 min  
**Environment:** Healthy multi-node kubeadm cluster  
**Mode:** Hands-on

## Objective

- Inspect/render a chart before installing.
- Manage release values and history.
- Upgrade and rollback a release.

## Scenario

A team ships Kubernetes resources as Helm. You need to treat Helm as release management, not as a magic package command.

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

1. Use local chart `assets/charts/cka-web`. Run `helm lint` and `helm template` first; inspect the generated Deployment/Service.
2. Install release `demo` into namespace `cka-helm`, creating it as needed.
3. Inspect `helm list`, status, values and created Kubernetes resources.
4. Upgrade replicaCount from 2 to 4 and verify the Deployment rollout plus Helm revision/history.
5. Perform another upgrade that sets an invalid nginx image tag. Observe Kubernetes failure while Helm release revision exists. Roll back to the previous working revision and prove recovery.
6. Uninstall only after recording history/evidence.

## Success criteria

- Rendered manifests make sense before apply.
- Release reaches 4 ready replicas in a working revision.
- Rollback restores healthy image/replicas and Helm history shows revisions.

## Verification

Run these (or an equivalent proof) and explain why each result proves the requirement:

```bash
helm list -A
helm status demo -n cka-helm
helm history demo -n cka-helm
kubectl get deploy,po,svc -n cka-helm
```

## Documentation drill

Without using the solution file, find the relevant upstream documentation for **Helm install/upgrade/rollback and values**. Locate the exact field/command you would need if the task wording changed. Time the lookup; target **under 2 minutes** by Week 4.

## Failure injection / stretch

1. Use `helm get manifest` and compare it with `helm template`.
2. Change a value using a small values file instead of `--set`, and inspect `helm get values`.

## Cleanup / reset

1. Delete the namespace/resources created for this lab unless the next lab reuses them.
2. Return any node labels/taints/configuration changed only for this exercise to the baseline state.
3. Run `kubectl get nodes` and confirm the cluster is healthy.

## Debrief

Answer these in your error log or notes:

1. What state does Helm track that plain `kubectl apply` does not expose the same way?
2. Why render before install during debugging?
3. What is the difference between Helm revision history and Deployment revision history?

## Solution

Do not open it until you have either completed the lab or spent the full timebox using official documentation: [`../../solutions/lab-28-helm-install-upgrade-and-rollback.md`](../../solutions/lab-28-helm-install-upgrade-and-rollback.md).
