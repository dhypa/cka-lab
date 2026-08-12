# Lab 41 — Incident: Broken Application Deployment

**Day:** 19  
**Primary domain:** Troubleshooting  
**Timebox:** 45–60 min  
**Environment:** Healthy multi-node kubeadm cluster  
**Mode:** Incident

## Objective

- Diagnose a multi-fault Deployment/Service incident.
- Repair the owning source rather than ephemeral children.
- Verify user-facing service recovery.

## Scenario

The provided application manifests represent a failed release. Several symptoms overlap: Pods run but are not Ready, and the Service cannot route correctly.

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

1. Create namespace `cka-debug` and apply `assets/broken-deployment.yaml` plus `assets/broken-service.yaml`. Do not inspect files before applying on your first attempt.
2. Set a 25-minute incident timer. Start with host/context then use your troubleshooting ladder. Record every observation in `/tmp/incident41.txt`.
3. Identify all independent faults required for successful HTTP through Service. Repair them in the Deployment/Service, not by hand-editing generated Pods/EndpointSlices.
4. From a disposable client, prove HTTP through `broken-web`; prove Deployment Ready replicas and EndpointSlice addresses.
5. After recovery, inspect the original files and compare the fault locations to your diagnostic path.

## Success criteria

- Deployment has 2 Ready replicas.
- Service EndpointSlice has expected ready addresses/port.
- In-cluster HTTP succeeds.
- Incident notes show evidence → hypothesis → change → verification.

## Verification

Run these (or an equivalent proof) and explain why each result proves the requirement:

```bash
kubectl rollout status deploy/broken-web -n cka-debug --timeout=90s
kubectl get endpointslice -n cka-debug -l kubernetes.io/service-name=broken-web -o wide
kubectl run inc41-check -n cka-debug --rm -i --restart=Never --image=busybox:1.36 -- wget -qO- http://broken-web
cat /tmp/incident41.txt
```

## Documentation drill

Without using the solution file, find the relevant upstream documentation for **Deployments/probes, Services/EndpointSlices and application troubleshooting**. Locate the exact field/command you would need if the task wording changed. Time the lookup; target **under 2 minutes** by Week 4.

## Failure injection / stretch

1. Reset and repeat without `kubectl edit`; use patch/set commands plus docs. Target 12 minutes.
2. Add a third fault (wrong image) and decide optimal repair order.

## Cleanup / reset

1. Delete the namespace/resources created for this lab unless the next lab reuses them.
2. Return any node labels/taints/configuration changed only for this exercise to the baseline state.
3. Run `kubectl get nodes` and confirm the cluster is healthy.

## Debrief

Answer these in your error log or notes:

1. What was the first independent fault you proved?
2. Could you have diagnosed Service faults before readiness was repaired?
3. Which command saved the most time?

## Solution

Do not open it until you have either completed the lab or spent the full timebox using official documentation: [`../../solutions/lab-41-incident-broken-application-deployment.md`](../../solutions/lab-41-incident-broken-application-deployment.md).
