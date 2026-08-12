# Lab 40 — Resource Usage, Logs and Events Triage

**Day:** 19  
**Primary domain:** Troubleshooting  
**Timebox:** 35–50 min  
**Environment:** Healthy multi-node kubeadm cluster  
**Mode:** Hands-on

## Objective

- Combine metrics, events and logs in a timeboxed triage.
- Identify OOM/restart/resource pressure evidence.
- Produce a concise incident hypothesis before editing.

## Scenario

A namespace contains several unhealthy workloads. Your goal is not to fix immediately; it is to rank evidence and state the likely cause of each within 15 minutes.

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

1. Create three disposable failure Pods: one crashing command, one invalid image, and (if safe) one memory-limited process designed to exceed its low memory limit.
2. Set a 15-minute timer. For each Pod capture phase/container state, restart count, last termination reason, relevant event, current/previous logs, and resource usage if metrics are available.
3. Write `/tmp/triage.txt` with one-line diagnosis and evidence pointer per Pod **before** making fixes.
4. Repair all three using owning manifests or Pod recreation as appropriate and prove stable state.

## Success criteria

- Triage report distinguishes runtime crash, image pull and OOM/resource failure.
- Evidence precedes repairs.
- Repaired workloads stop generating corresponding failures.

## Verification

Run these (or an equivalent proof) and explain why each result proves the requirement:

```bash
kubectl get pods -n cka-debug -o wide
kubectl get events -n cka-debug --sort-by=.lastTimestamp | tail -30
kubectl top pods -n cka-debug 2>/dev/null || true
cat /tmp/triage.txt
```

## Documentation drill

Without using the solution file, find the relevant upstream documentation for **debug running Pods, events, logs and resource metrics**. Locate the exact field/command you would need if the task wording changed. Time the lookup; target **under 2 minutes** by Week 4.

## Failure injection / stretch

1. Use JSONPath to print last termination reason/restartCount for all Pods in the namespace.
2. Create an initContainer failure and explain how its status differs from main-container CrashLoop.

## Cleanup / reset

1. Delete the namespace/resources created for this lab unless the next lab reuses them.
2. Return any node labels/taints/configuration changed only for this exercise to the baseline state.
3. Run `kubectl get nodes` and confirm the cluster is healthy.

## Debrief

Answer these in your error log or notes:

1. Which evidence source was fastest for each failure?
2. What failure had no useful application logs?
3. How can resource pressure show at Pod versus Node level?

## Solution

Do not open it until you have either completed the lab or spent the full timebox using official documentation: [`../../solutions/lab-40-resource-usage-logs-and-events-triage.md`](../../solutions/lab-40-resource-usage-logs-and-events-triage.md).
