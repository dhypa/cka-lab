# Lab 46 — Timed kubectl Resource Speed Drill

**Day:** 22  
**Primary domain:** Exam execution / Workloads  
**Timebox:** 30–45 min  
**Environment:** Healthy multi-node kubeadm cluster  
**Mode:** Timed circuit

## Objective

- Generate common resources rapidly without sacrificing correctness.
- Use dry-run YAML, patch/set/scale/rollout commands fluently.
- Measure and reduce command-retrieval latency.

## Scenario

You know the concepts; now remove unnecessary typing. This circuit rewards correct verified output, not exotic aliases.

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

1. Start a 20-minute timer in a clean namespace `cka-speed`. Without solutions create: Pod `p1` nginx; Deployment `d1` 3 replicas; Service `d1` port 8080→80; ConfigMap `cfg` with `MODE=fast`; Secret `sec` with `token=fast`; ServiceAccount `reader`; Role allowing get/list Pods; RoleBinding to reader.
2. Patch `d1` to add label `tier=web` to Pod template, set CPU request 20m, scale to 4 and wait for rollout.
3. Save names of all ready `d1` Pods to `/tmp/d1-pods.txt` using output processing rather than manual typing.
4. Delete one Pod and prove controller replacement.
5. Record completion time and every command you had to look up.

## Success criteria

- All requested objects exist with exact names/scope.
- RBAC positive/negative test passes.
- Deployment has 4 Ready replicas with requested CPU.
- Circuit completes in ≤20 min by final repeat.

## Verification

Run these (or an equivalent proof) and explain why each result proves the requirement:

```bash
kubectl get all,cm,secret,sa,role,rolebinding -n cka-speed
kubectl auth can-i list pods -n cka-speed --as=system:serviceaccount:cka-speed:reader
wc -l /tmp/d1-pods.txt
```

## Documentation drill

Without using the solution file, find the relevant upstream documentation for **kubectl generators/quick reference and JSONPath/output formats**. Locate the exact field/command you would need if the task wording changed. Time the lookup; target **under 2 minutes** by Week 4.

## Failure injection / stretch

1. Reset namespace and repeat in 12 minutes.
2. Repeat using only `k` alias plus editor; decide which style is actually faster for you.

## Cleanup / reset

1. Delete the namespace/resources created for this lab unless the next lab reuses them.
2. Return any node labels/taints/configuration changed only for this exercise to the baseline state.
3. Run `kubectl get nodes` and confirm the cluster is healthy.

## Debrief

Answer these in your error log or notes:

1. Which three commands cost the most retrieval time?
2. Which generated YAML still needs manual edits often?
3. What is your reliable way to produce requested output files?

## Solution

Do not open it until you have either completed the lab or spent the full timebox using official documentation: [`../../solutions/lab-46-timed-kubectl-resource-speed-drill.md`](../../solutions/lab-46-timed-kubectl-resource-speed-drill.md).
