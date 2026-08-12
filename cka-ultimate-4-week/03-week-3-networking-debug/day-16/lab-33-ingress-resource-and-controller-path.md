# Lab 33 — Ingress Resource and Controller Path

**Day:** 16  
**Primary domain:** Services & Networking  
**Timebox:** 35–50 min  
**Environment:** Healthy multi-node kubeadm cluster  
**Mode:** Hands-on

## Objective

- Create an Ingress resource for a Service.
- Distinguish API resource from Ingress controller implementation.
- Use status/events/controller logs as evidence.

## Scenario

A team has created an Ingress YAML but traffic does not work. Your first job is to determine whether the cluster has an Ingress controller/class capable of realising it.

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

1. Inventory `IngressClass` objects and controller Pods before creating anything.
2. Create namespace `cka-ingress`, Deployment/Service `web`, then an Ingress routing host `web.cka.local` path `/` to Service `web:80`; set the class using the mechanism expected by your controller.
3. Inspect Ingress status/events and the chosen controller logs. If a controller exists, route a request using appropriate Host header/address. If none exists, stop at API/status analysis and document that a resource alone does not create a proxy.
4. Introduce a backend Service name typo and compare route/controller status/log evidence; repair it.

## Success criteria

- You explicitly establish whether an Ingress controller/class exists.
- Ingress references a real Service/port after repair.
- With a controller, HTTP reaches backend; without one, you correctly report the missing implementation rather than faking success.

## Verification

Run these (or an equivalent proof) and explain why each result proves the requirement:

```bash
kubectl get ingressclass
kubectl get ingress -n cka-ingress -o wide
kubectl describe ingress -n cka-ingress
kubectl get svc,endpointslice -n cka-ingress
```

## Documentation drill

Without using the solution file, find the relevant upstream documentation for **Ingress, IngressClass and controller concepts**. Locate the exact field/command you would need if the task wording changed. Time the lookup; target **under 2 minutes** by Week 4.

## Failure injection / stretch

1. Install a small Ingress controller only by its current official docs if your lab cluster has none, then repeat live data-plane proof.
2. Compare Ingress API status with backend Service EndpointSlice during a backend failure.

## Cleanup / reset

1. Delete the namespace/resources created for this lab unless the next lab reuses them.
2. Return any node labels/taints/configuration changed only for this exercise to the baseline state.
3. Run `kubectl get nodes` and confirm the cluster is healthy.

## Debrief

Answer these in your error log or notes:

1. What resource tells a controller implementation/class relationship?
2. What does an Ingress object do without a controller?
3. Which backend evidence would you inspect before controller logs?

## Solution

Do not open it until you have either completed the lab or spent the full timebox using official documentation: [`../../solutions/lab-33-ingress-resource-and-controller-path.md`](../../solutions/lab-33-ingress-resource-and-controller-path.md).
