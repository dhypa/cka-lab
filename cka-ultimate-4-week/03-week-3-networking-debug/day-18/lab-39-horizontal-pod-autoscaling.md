# Lab 39 — Horizontal Pod Autoscaling

**Day:** 18  
**Primary domain:** Workloads & Scheduling  
**Timebox:** 35–50 min  
**Environment:** Healthy multi-node kubeadm cluster  
**Mode:** Hands-on

## Objective

- Create HPA for a Deployment.
- Understand metric prerequisites and resource requests.
- Inspect scaling conditions/events.

## Scenario

A CPU-bound workload should scale between 1 and 5 replicas around 50% CPU utilisation. First prove that a metrics pipeline exists.

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

1. Run `kubectl top nodes`/`kubectl top pods`; if metrics API is absent, install Metrics Server using current official guidance for your lab environment or complete the manifest/status branch.
2. Create namespace `cka-hpa`, Deployment `cpu-web` with CPU request `50m`, and Service.
3. Create HPA targeting 50% CPU, min 1, max 5 using current autoscaling API/`kubectl autoscale`.
4. Inspect HPA current/desired metrics/conditions.
5. Generate sustained CPU load using a suitable test workload/request loop and observe scale-up, then stop load and observe scale-down behaviour (allowing for stabilisation windows).

## Success criteria

- Metrics are available or absence is explicitly diagnosed.
- HPA spec targets correct workload/min/max/CPU utilisation.
- With metrics/load, desired/current replicas change; conditions explain state.

## Verification

Run these (or an equivalent proof) and explain why each result proves the requirement:

```bash
kubectl top nodes 2>/dev/null || true
kubectl get hpa -n cka-hpa
kubectl describe hpa -n cka-hpa
kubectl get deploy cpu-web -n cka-hpa -w
```

## Documentation drill

Without using the solution file, find the relevant upstream documentation for **HorizontalPodAutoscaler and resource metrics**. Locate the exact field/command you would need if the task wording changed. Time the lookup; target **under 2 minutes** by Week 4.

## Failure injection / stretch

1. Remove CPU request from the workload and inspect HPA metric calculation symptoms; restore it.
2. Use `kubectl get --raw /apis/metrics.k8s.io/` to distinguish API availability from HPA configuration.

## Cleanup / reset

1. Delete the namespace/resources created for this lab unless the next lab reuses them.
2. Return any node labels/taints/configuration changed only for this exercise to the baseline state.
3. Run `kubectl get nodes` and confirm the cluster is healthy.

## Debrief

Answer these in your error log or notes:

1. Why do CPU requests matter for utilisation percentage?
2. What component/API supplies resource metrics?
3. Which HPA status fields tell you why scaling is not occurring?

## Solution

Do not open it until you have either completed the lab or spent the full timebox using official documentation: [`../../solutions/lab-39-horizontal-pod-autoscaling.md`](../../solutions/lab-39-horizontal-pod-autoscaling.md).
