# Lab 06 — Requests, Limits and Self-Healing Probes

**Day:** 3  
**Primary domain:** Workloads & Scheduling / Troubleshooting  
**Timebox:** 35–50 min  
**Environment:** Healthy multi-node kubeadm cluster  
**Mode:** Hands-on

## Objective

- Configure resource requests/limits correctly.
- Distinguish readiness, liveness and startup semantics.
- Diagnose a probe-induced availability problem.

## Scenario

A web Pod runs, but it never becomes a Service-ready backend because its readiness probe checks the wrong path. You must fix availability without introducing restart loops.

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

1. Create Deployment `probe-web` in `cka-lab` with 2 `nginx:1.27` replicas, request `20m` CPU/`32Mi` memory and limits `100m` CPU/`64Mi` memory.
2. Add readiness probe HTTP GET `/not-real` on port 80 every 3 seconds.
3. Expose it as Service `probe-web` port 80 and prove EndpointSlice has no ready addresses despite Running Pods.
4. Use `describe`/events to establish probe failure, then repair readiness path to `/`.
5. Add a liveness probe to `/` with a conservative initial delay. Explain why using the original bad path for liveness would create a different failure mode.

## Success criteria

- Pods have requested/limited resources.
- EndpointSlice becomes populated only after readiness repair.
- No unnecessary restart loop is introduced.

## Verification

Run these (or an equivalent proof) and explain why each result proves the requirement:

```bash
kubectl get po -n cka-lab -l app=probe-web
kubectl describe po -n cka-lab -l app=probe-web | grep -A4 -E 'Readiness|Liveness'
kubectl get endpointslice -n cka-lab -l kubernetes.io/service-name=probe-web -o wide
```

## Documentation drill

Without using the solution file, find the relevant upstream documentation for **resource management and liveness/readiness/startup probes**. Locate the exact field/command you would need if the task wording changed. Time the lookup; target **under 2 minutes** by Week 4.

## Failure injection / stretch

1. Create a liveness probe that fails after 10 seconds, observe a restart and `--previous` logs/events, then revert it.
2. Explain where startup probes are useful for genuinely slow-starting applications.

## Cleanup / reset

1. Delete the namespace/resources created for this lab unless the next lab reuses them.
2. Return any node labels/taints/configuration changed only for this exercise to the baseline state.
3. Run `kubectl get nodes` and confirm the cluster is healthy.

## Debrief

Answer these in your error log or notes:

1. What does a readiness failure change?
2. What does a liveness failure change?
3. How do requests and limits serve different purposes?

## Solution

Do not open it until you have either completed the lab or spent the full timebox using official documentation: [`../../solutions/lab-06-requests-limits-and-self-healing-probes.md`](../../solutions/lab-06-requests-limits-and-self-healing-probes.md).
