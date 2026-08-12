# Lab 15 — Week 1 Capstone: Ship a Stateful Web Tier

**Day:** 7  
**Primary domain:** Mixed: Workloads, Networking, Storage, Troubleshooting  
**Timebox:** 90–120 min  
**Environment:** Healthy multi-node kubeadm cluster  
**Mode:** Capstone

## Objective

- Combine workload, scheduling, config, Service, DNS and storage skills without command hints.
- Diagnose at least two intentionally introduced failures.
- Produce a compact evidence report.

## Scenario

You are given a small internal web tier requirement and a deliberately imperfect starting cluster. Build it as if it were an exam task: terse requirements, no tutorial sequence.

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

1. Create namespace `cka-capstone`. Create ConfigMap `web-config` with `ENV=week1` and Secret `web-secret` with key `token=capstone`.
2. Provide a PVC `web-data` using a working storage method available in your cluster.
3. Run a 3-replica nginx Deployment `web` with CPU/memory requests, a correct readiness probe, `ENV` from ConfigMap, and the claim mounted at `/usr/share/nginx/html/data`.
4. Ensure at least one eligible worker is labelled `zone=practice`; require the web workload to schedule only on nodes with that label. Do not use `nodeName`.
5. Expose the Deployment as ClusterIP Service `web` on port 8080 targeting port 80.
6. Create a BusyBox client and prove DNS plus HTTP service access.
7. Now inject **two** faults of your choice from: wrong Service selector, wrong targetPort, bad readiness path, impossible node affinity, missing ConfigMap reference. Hand your terminal to your future self: wait two minutes, then diagnose and repair using evidence only.
8. Write `/tmp/week1-capstone.txt` containing namespace, ready replica count, Service ClusterIP, endpoint count and node names hosting web Pods.

## Success criteria

- 3 ready web replicas after repair.
- All Pods satisfy the intended node constraint.
- Service DNS resolves and HTTP on port 8080 succeeds.
- PVC is Bound/usable.
- `/tmp/week1-capstone.txt` contains the requested evidence generated from cluster state.

## Verification

Run these (or an equivalent proof) and explain why each result proves the requirement:

```bash
kubectl get deploy,po,svc,pvc -n cka-capstone -o wide
kubectl get endpointslice -n cka-capstone -l kubernetes.io/service-name=web -o wide
kubectl run verify-week1 -n cka-capstone --rm -i --restart=Never --image=busybox:1.36 -- wget -qO- http://web:8080
cat /tmp/week1-capstone.txt
```

## Documentation drill

Without using the solution file, find the relevant upstream documentation for **Deployment, probes, Services, DNS, scheduling and PVC documentation — choose pages based on the fault**. Locate the exact field/command you would need if the task wording changed. Time the lookup; target **under 2 minutes** by Week 4.

## Failure injection / stretch

1. Repeat the capstone from an empty namespace with a 25-minute timebox.
2. Ask someone/shell script to change one selector/port/probe after you finish, then troubleshoot without looking at the diff.

## Cleanup / reset

1. Delete the namespace/resources created for this lab unless the next lab reuses them.
2. Return any node labels/taints/configuration changed only for this exercise to the baseline state.
3. Run `kubectl get nodes` and confirm the cluster is healthy.

## Debrief

Answer these in your error log or notes:

1. Which layer failed first for each injected fault?
2. What was the single most informative command in the incident?
3. Which Week 1 skill is still Amber/Red and what exact repeat will turn it Green?

## Solution

Do not open it until you have either completed the lab or spent the full timebox using official documentation: [`../../solutions/lab-15-week-1-capstone-ship-a-stateful-web-tier.md`](../../solutions/lab-15-week-1-capstone-ship-a-stateful-web-tier.md).
