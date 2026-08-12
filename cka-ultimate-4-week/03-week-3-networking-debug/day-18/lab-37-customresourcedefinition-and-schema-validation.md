# Lab 37 — CustomResourceDefinition and Schema Validation

**Day:** 18  
**Primary domain:** Cluster Architecture, Installation & Configuration  
**Timebox:** 35–50 min  
**Environment:** Healthy multi-node kubeadm cluster  
**Mode:** Hands-on

## Objective

- Install a namespaced CRD.
- Create valid/invalid custom resources and observe API validation.
- Understand CRDs extend storage/API, not behaviour by themselves.

## Scenario

A platform team needs a `Widget` API with typed fields. Your task is to create the CRD and prove the API server enforces its schema.

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

1. Create namespace `cka-crd`. Apply `assets/widgets-crd.yaml`.
2. Use `kubectl api-resources` and `kubectl explain widget.spec` to prove discovery/schema integration.
3. Create valid Widget `small` with `size: 2`, `enabled: true`.
4. Attempt invalid Widget with `size: 0` and another with `enabled: "yes"`; capture API validation failures.
5. List/get using plural, kind and short name.
6. Explain what **will not happen** to a Widget without a controller/operator watching it.

## Success criteria

- CRD Established condition is true.
- Valid object persists; invalid schema objects are rejected.
- Custom resource is discoverable by kubectl.

## Verification

Run these (or an equivalent proof) and explain why each result proves the requirement:

```bash
kubectl get crd widgets.training.cka.io
kubectl api-resources | grep -i widget
kubectl get widgets -n cka-crd
kubectl explain widget.spec
```

## Documentation drill

Without using the solution file, find the relevant upstream documentation for **CustomResourceDefinitions and structural OpenAPI schema**. Locate the exact field/command you would need if the task wording changed. Time the lookup; target **under 2 minutes** by Week 4.

## Failure injection / stretch

1. Add required enum/string field to a new CRD version in a safe copy; inspect versioning requirements before applying.
2. Add a printer column to the CRD and observe `kubectl get widgets` output.

## Cleanup / reset

1. Delete the namespace/resources created for this lab unless the next lab reuses them.
2. Return any node labels/taints/configuration changed only for this exercise to the baseline state.
3. Run `kubectl get nodes` and confirm the cluster is healthy.

## Debrief

Answer these in your error log or notes:

1. What does a CRD add to Kubernetes?
2. What adds reconciliation behaviour?
3. Where is schema validation performed?

## Solution

Do not open it until you have either completed the lab or spent the full timebox using official documentation: [`../../solutions/lab-37-customresourcedefinition-and-schema-validation.md`](../../solutions/lab-37-customresourcedefinition-and-schema-validation.md).
