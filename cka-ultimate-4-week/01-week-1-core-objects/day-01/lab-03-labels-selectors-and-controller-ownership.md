# Lab 03 — Labels, Selectors and Controller Ownership

**Day:** 1  
**Primary domain:** Workloads & Scheduling / Troubleshooting  
**Timebox:** 35–50 min  
**Environment:** Healthy multi-node kubeadm cluster  
**Mode:** Hands-on

## Objective

- Reason about labels and selectors as relationships, not decoration.
- Inspect Deployment → ReplicaSet → Pod ownership.
- Diagnose an intentionally mismatched Service-style selector.

## Scenario

A controller reports healthy replicas, but another object cannot find the intended Pods. You must prove which labels and selectors actually connect objects.

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

1. Inspect labels on `web` Pods and the Deployment selector.
2. Show the ownerReferences chain from one Pod to its ReplicaSet and from the ReplicaSet to the Deployment.
3. Add label `tier=frontend` to the Pod template through the Deployment, not by hand-labeling individual Pods.
4. Create a temporary Service `web-label-test` whose selector intentionally uses `tier=backend`; prove it has no ready endpoints.
5. Repair the selector to `app=web,tier=frontend` and prove endpoints appear.

## Success criteria

- New Pods have `tier=frontend`.
- You can identify the owning ReplicaSet/Deployment from metadata.
- EndpointSlice is empty before selector repair and populated afterwards.

## Verification

Run these (or an equivalent proof) and explain why each result proves the requirement:

```bash
kubectl get po -n cka-lab -l app=web --show-labels
kubectl get svc web-label-test -n cka-lab -o yaml
kubectl get endpointslice -n cka-lab -l kubernetes.io/service-name=web-label-test -o wide
```

## Documentation drill

Without using the solution file, find the relevant upstream documentation for **labels/selectors, recommended labels, and owner references**. Locate the exact field/command you would need if the task wording changed. Time the lookup; target **under 2 minutes** by Week 4.

## Failure injection / stretch

1. Manually change a label on one Pod and observe how the Deployment itself does not immediately recreate it if the immutable selector still matches; then reason about what would happen if the selector label were removed.
2. Use a JSONPath expression to print Pod name and owner kind/name.

## Cleanup / reset

1. Delete the namespace/resources created for this lab unless the next lab reuses them.
2. Return any node labels/taints/configuration changed only for this exercise to the baseline state.
3. Run `kubectl get nodes` and confirm the cluster is healthy.

## Debrief

Answer these in your error log or notes:

1. Which selector on a Deployment is effectively part of controller identity?
2. How do owner references differ from labels?
3. Why are EndpointSlices better evidence than “the Service exists”?

## Solution

Do not open it until you have either completed the lab or spent the full timebox using official documentation: [`../../solutions/lab-03-labels-selectors-and-controller-ownership.md`](../../solutions/lab-03-labels-selectors-and-controller-ownership.md).
