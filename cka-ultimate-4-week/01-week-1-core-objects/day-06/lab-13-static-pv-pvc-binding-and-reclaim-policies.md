# Lab 13 — Static PV/PVC Binding and Reclaim Policies

**Day:** 6  
**Primary domain:** Storage  
**Timebox:** 35–50 min  
**Environment:** Healthy multi-node kubeadm cluster  
**Mode:** Hands-on

## Objective

- Create compatible PV/PVC pairs.
- Mount a claim and prove persistence.
- Understand `Retain` behaviour after claim deletion.

## Scenario

A small stateful workload needs a statically supplied volume. You must bind the claim deterministically and preserve backing data after claim deletion.

## Prerequisites

- A healthy practice cluster and working `kubectl`.

## Safety / starting-state check

> The hostPath backing data lives on one node. Pin writer/reader consistently for the exercise, and treat this as a learning primitive rather than production storage design.

Run and read the output before proceeding:

```bash
hostname
kubectl config current-context
kubectl get nodes -o wide
```

## Lab setup

1. Create any named namespace/resources only when instructed. Do not reuse leftovers from a previous attempt.

## Tasks

1. Create namespace `cka-storage`. Apply/adapt `assets/storage-static.yaml` so PV `cka-static-pv` and PVC `cka-static-pvc` bind.
2. Create Pod `writer` on a node compatible with the hostPath, mount claim at `/data`, and write `cka-persisted` to `/data/value.txt`.
3. Delete the writer Pod. Recreate a Pod `reader` mounting the same PVC and prove the value remains.
4. Record PV/PVC phase, claimRef and reclaim policy.
5. Delete the PVC only after recording evidence. Observe the PV state with `Retain` and explain the manual recovery/cleanup implication.

## Success criteria

- PV/PVC reach `Bound` before workload starts.
- Recreated reader sees the persisted value.
- You can explain why Retain prevents automatic disposal of backing storage.

## Verification

Run these (or an equivalent proof) and explain why each result proves the requirement:

```bash
kubectl get pv cka-static-pv
kubectl get pvc cka-static-pvc -n cka-storage
kubectl exec -n cka-storage reader -- cat /data/value.txt
```

## Documentation drill

Without using the solution file, find the relevant upstream documentation for **PersistentVolumes, PVC binding, access modes and reclaim policies**. Locate the exact field/command you would need if the task wording changed. Time the lookup; target **under 2 minutes** by Week 4.

## Failure injection / stretch

1. Create a second PVC with incompatible `storageClassName` or excessive size; inspect why it remains Pending.
2. Research how a Released Retain PV can be made available for a new claim safely in a real environment.

## Cleanup / reset

1. Delete the namespace/resources created for this lab unless the next lab reuses them.
2. Return any node labels/taints/configuration changed only for this exercise to the baseline state.
3. Run `kubectl get nodes` and confirm the cluster is healthy.

## Debrief

Answer these in your error log or notes:

1. What conditions must match for static binding?
2. What lifetime is independent: Pod, PVC, PV, backing storage?
3. What operational burden does Retain introduce?

## Solution

Do not open it until you have either completed the lab or spent the full timebox using official documentation: [`../../solutions/lab-13-static-pv-pvc-binding-and-reclaim-policies.md`](../../solutions/lab-13-static-pv-pvc-binding-and-reclaim-policies.md).
