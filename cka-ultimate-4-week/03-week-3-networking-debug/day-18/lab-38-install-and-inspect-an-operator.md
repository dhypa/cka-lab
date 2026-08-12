# Lab 38 — Install and Inspect an Operator

**Day:** 18  
**Primary domain:** Cluster Architecture, Installation & Configuration  
**Timebox:** 60–90 min  
**Environment:** Healthy multi-node kubeadm cluster  
**Mode:** Guided inspection lab

## Objective

- Identify the pieces an operator installs.
- Trace custom resource → controller → managed resources/status.
- Inspect RBAC and reconciliation evidence.

## Scenario

CKA expects awareness of operators. Rather than memorise one vendor, learn to inspect any small reputable operator supplied by docs/task environment.

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

1. Choose a lightweight operator from an official/reputable upstream project that supports your Kubernetes version, or use an operator already installed in your environment. Record exact source/version.
2. Before creating a CR, inventory its namespace, Deployment/Pods, ServiceAccount, Roles/ClusterRoles/Bindings and CRDs.
3. Read one CRD schema and controller Deployment command/image.
4. Create the smallest documented custom resource. Watch controller logs, events, child resources and custom-resource status.
5. Change one supported spec field and observe reconciliation. Delete the CR and inspect finalizer/cleanup behaviour if present.

## Success criteria

- You can identify controller workload, identity/RBAC and CRDs.
- A spec change causes observable reconciliation.
- You can explain finalizer/status behaviour you actually saw.

## Verification

Run these (or an equivalent proof) and explain why each result proves the requirement:

```bash
kubectl get crd | head
kubectl get deploy,po,sa -A | grep -i operator || true
kubectl get clusterrole,clusterrolebinding | grep -i operator || true
```

## Documentation drill

Without using the solution file, find the relevant upstream documentation for **operators/custom controllers, CRDs, finalizers and owner references**. Locate the exact field/command you would need if the task wording changed. Time the lookup; target **under 2 minutes** by Week 4.

## Failure injection / stretch

1. Scale operator controller to zero, change CR spec, observe no reconciliation, then restore and watch it converge.
2. Trace one managed child resource ownerReference back to the custom resource or explain the project’s ownership mechanism.

## Cleanup / reset

1. Delete the namespace/resources created for this lab unless the next lab reuses them.
2. Return any node labels/taints/configuration changed only for this exercise to the baseline state.
3. Run `kubectl get nodes` and confirm the cluster is healthy.

## Debrief

Answer these in your error log or notes:

1. How is an operator different from a CRD?
2. What two places reveal what it can do: code aside?
3. What does reconciliation mean operationally?

## Solution

Do not open it until you have either completed the lab or spent the full timebox using official documentation: [`../../solutions/lab-38-install-and-inspect-an-operator.md`](../../solutions/lab-38-install-and-inspect-an-operator.md).
