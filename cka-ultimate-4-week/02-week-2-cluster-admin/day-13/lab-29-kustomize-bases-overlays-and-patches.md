# Lab 29 — Kustomize Bases, Overlays and Patches

**Day:** 13  
**Primary domain:** Cluster Architecture, Installation & Configuration  
**Timebox:** 35–50 min  
**Environment:** Healthy multi-node kubeadm cluster  
**Mode:** Hands-on

## Objective

- Render bases/overlays with kubectl Kustomize integration.
- Apply namespace/name/replica/label transforms.
- Use patches without copying whole manifests.

## Scenario

The same workload must deploy to dev and prod with environment-specific names, namespaces, replica counts and resource settings while keeping one reusable base.

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

1. Inspect `assets/kustomize/base` and both overlays. Create namespaces `cka-kustomize-dev` and `cka-kustomize-prod`.
2. Run `kubectl kustomize` for each overlay before applying. Diff the rendered objects mentally/file-wise.
3. Apply both overlays with `kubectl apply -k`.
4. Verify dev has 1 replica, prod 3 replicas, environment labels and prod resource patch.
5. Change prod nginx image tag through the overlay using a Kustomize image transform or patch; render/diff before apply and verify rollout.
6. Delete with `kubectl delete -k` after evidence.

## Success criteria

- Two environments derive from same base without copied Deployment YAML.
- Rendered prod output contains intended replica/resources/image transformations.
- Live objects carry prefix/namespace/labels as expected.

## Verification

Run these (or an equivalent proof) and explain why each result proves the requirement:

```bash
kubectl kustomize assets/kustomize/overlays/dev | head -40
kubectl kustomize assets/kustomize/overlays/prod | head -60
kubectl get deploy -n cka-kustomize-dev
kubectl get deploy -n cka-kustomize-prod -o yaml | grep -A8 resources:
```

## Documentation drill

Without using the solution file, find the relevant upstream documentation for **Kustomize declarative management, bases, overlays, patches and image transforms**. Locate the exact field/command you would need if the task wording changed. Time the lookup; target **under 2 minutes** by Week 4.

## Failure injection / stretch

1. Introduce a bad patch path and read render-time error; fix it without editing the base.
2. Add a ConfigMap generator to one overlay and inspect name hashing/update behaviour.

## Cleanup / reset

1. Delete the namespace/resources created for this lab unless the next lab reuses them.
2. Return any node labels/taints/configuration changed only for this exercise to the baseline state.
3. Run `kubectl get nodes` and confirm the cluster is healthy.

## Debrief

Answer these in your error log or notes:

1. What belongs in a base versus overlay?
2. Why is rendering such a strong debugging tool?
3. When would Helm and Kustomize solve different packaging/customisation problems?

## Solution

Do not open it until you have either completed the lab or spent the full timebox using official documentation: [`../../solutions/lab-29-kustomize-bases-overlays-and-patches.md`](../../solutions/lab-29-kustomize-bases-overlays-and-patches.md).
