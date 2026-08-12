# Lab 36 — EndpointSlices and Selector-less Services

**Day:** 17  
**Primary domain:** Services & Networking  
**Timebox:** 35–50 min  
**Environment:** Healthy multi-node kubeadm cluster  
**Mode:** Hands-on

## Objective

- Inspect EndpointSlice topology/ports/conditions.
- Create a selector-less Service and supply endpoints explicitly.
- Diagnose stale/wrong manual endpoints.

## Scenario

You need a stable Kubernetes Service name for an endpoint not selected from Pods. This forces you to understand what selector-based Services normally automate.

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

1. Create namespace `cka-net-manual`; create a Pod `manual-backend` serving on port 80 and record its Pod IP.
2. Create ClusterIP Service `manual-service` port 80 **without a selector**. Show no automatically managed endpoint addresses appear for it.
3. Create an EndpointSlice associated with the Service via `kubernetes.io/service-name: manual-service`, with address set to backend Pod IP and port 80.
4. From a client, resolve/reach `manual-service`.
5. Delete/recreate backend Pod so IP changes. Observe that manually managed EndpointSlice is now stale; update it and prove recovery.

## Success criteria

- Selector-less Service resolves and routes only after manual EndpointSlice is correct.
- You can distinguish controller-managed endpoints from manual responsibility.
- Stale endpoint failure is diagnosed from live addresses.

## Verification

Run these (or an equivalent proof) and explain why each result proves the requirement:

```bash
kubectl get svc manual-service -n cka-net-manual -o yaml
kubectl get endpointslice -n cka-net-manual -l kubernetes.io/service-name=manual-service -o yaml
kubectl get pod manual-backend -n cka-net-manual -o wide
```

## Documentation drill

Without using the solution file, find the relevant upstream documentation for **Services without selectors and EndpointSlices**. Locate the exact field/command you would need if the task wording changed. Time the lookup; target **under 2 minutes** by Week 4.

## Failure injection / stretch

1. Mark an EndpointSlice endpoint condition `ready: false` and observe implementation behaviour/document semantics.
2. Explain why putting arbitrary external IPs behind a Service may have security/routing constraints.

## Cleanup / reset

1. Delete the namespace/resources created for this lab unless the next lab reuses them.
2. Return any node labels/taints/configuration changed only for this exercise to the baseline state.
3. Run `kubectl get nodes` and confirm the cluster is healthy.

## Debrief

Answer these in your error log or notes:

1. What automation do you lose with a selector-less Service?
2. Why is a Pod IP a fragile manual external target?
3. Which object should you inspect when Service selector looks correct but endpoints are surprising?

## Solution

Do not open it until you have either completed the lab or spent the full timebox using official documentation: [`../../solutions/lab-36-endpointslices-and-selector-less-services.md`](../../solutions/lab-36-endpointslices-and-selector-less-services.md).
