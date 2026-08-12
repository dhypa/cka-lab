# Lab 14 — StorageClasses and Dynamic Provisioning

**Day:** 6  
**Primary domain:** Storage  
**Timebox:** 35–50 min  
**Environment:** Healthy multi-node kubeadm cluster  
**Mode:** Hands-on

## Objective

- Inspect StorageClasses and provisioners.
- Create a PVC that triggers dynamic provisioning when supported.
- Troubleshoot a Pending dynamic claim methodically.

## Scenario

A team requests storage without administrators pre-creating a PV. You need to prove whether the cluster has a working dynamic provisioner and use the appropriate class.

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

1. List StorageClasses and identify the default class, provisioner, reclaimPolicy and volumeBindingMode.
2. If your cluster has a working dynamic provisioner, create PVC `dynamic-pvc` for 128Mi and wait for a new PV. If none exists, install a simple lab provisioner using its official instructions or perform the analysis-only branch below.
3. Mount the claim in a Pod and write/read a marker.
4. Create `broken-pvc` referencing a nonexistent StorageClass; inspect events and explain the Pending cause.
5. Delete only lab claims and observe backing PV cleanup according to class reclaim policy.

## Success criteria

- You can identify whether dynamic provisioning capability exists before creating claims.
- A valid dynamic claim binds and is usable when a provisioner exists.
- Broken claim diagnosis cites StorageClass/provisioner evidence, not guesswork.

## Verification

Run these (or an equivalent proof) and explain why each result proves the requirement:

```bash
kubectl get storageclass
kubectl get pvc -n cka-storage
kubectl get pv
kubectl describe pvc broken-pvc -n cka-storage | tail -30
```

## Documentation drill

Without using the solution file, find the relevant upstream documentation for **StorageClasses and dynamic volume provisioning**. Locate the exact field/command you would need if the task wording changed. Time the lookup; target **under 2 minutes** by Week 4.

## Failure injection / stretch

1. Compare `Immediate` with `WaitForFirstConsumer` binding mode and explain why topology-aware storage can benefit from the latter.
2. If no provisioner is available, author a StorageClass that names a fake provisioner and demonstrate why merely creating the object does not provision anything.

## Cleanup / reset

1. Delete the namespace/resources created for this lab unless the next lab reuses them.
2. Return any node labels/taints/configuration changed only for this exercise to the baseline state.
3. Run `kubectl get nodes` and confirm the cluster is healthy.

## Debrief

Answer these in your error log or notes:

1. What component actually reacts to a StorageClass provisioner name?
2. What does `WaitForFirstConsumer` defer?
3. How would you tell static versus dynamically provisioned PVs apart?

## Solution

Do not open it until you have either completed the lab or spent the full timebox using official documentation: [`../../solutions/lab-14-storageclasses-and-dynamic-provisioning.md`](../../solutions/lab-14-storageclasses-and-dynamic-provisioning.md).
