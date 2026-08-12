# Lab 44 — Incident: Control Plane Static Pod Failure

**Day:** 20  
**Primary domain:** Troubleshooting / Cluster Architecture  
**Timebox:** 45–60 min  
**Environment:** Disposable kubeadm controlplane with direct SSH  
**Mode:** Incident

## Objective

- Recover an API/control-plane failure when kubectl may not work.
- Use static Pod manifests, kubelet journal and CRI logs.
- Avoid making a broken manifest worse.

## Scenario

The API server stops responding after a configuration edit. The normal reflex—`kubectl describe`—is unavailable. You must work from the control-plane node.

## Prerequisites

- A healthy practice cluster and working `kubectl`.

## Safety / starting-state check

> High-blast-radius controlled failure. VM snapshot is mandatory. Back up manifest outside `/etc/kubernetes/manifests`.

Run and read the output before proceeding:

```bash
hostname
kubectl config current-context
kubectl get nodes -o wide
```

## Lab setup

1. Create any named namespace/resources only when instructed. Do not reuse leftovers from a previous attempt.

## Tasks

1. Take a controlplane snapshot. Save a copy of `/etc/kubernetes/manifests/kube-apiserver.yaml` **outside** that directory.
2. Inject one controlled fault: add a definitely invalid kube-apiserver command flag to the live manifest. Wait for kubelet to recreate/retry the static Pod and confirm kubectl/API failure.
3. Set a 20-minute timer. On controlplane use kubelet journal, CRI container list/logs, and manifest inspection to find the invalid flag.
4. Remove only the bad change. Watch kubelet/runtime until API server returns, then verify `/readyz` and cluster state.
5. Compare recovery evidence with Week 2 anatomy notes.

## Success criteria

- API server becomes reachable and ready again.
- Other control-plane state remains intact.
- Recovery does not depend on `kubectl` while API is unavailable.

## Verification

Run these (or an equivalent proof) and explain why each result proves the requirement:

```bash
kubectl get --raw=/readyz?verbose
kubectl get nodes
ssh controlplane "sudo systemctl is-active kubelet"
```

## Documentation drill

Without using the solution file, find the relevant upstream documentation for **static Pod troubleshooting, kubelet logs and control-plane components**. Locate the exact field/command you would need if the task wording changed. Time the lookup; target **under 2 minutes** by Week 4.

## Failure injection / stretch

1. Repeat with scheduler manifest moved temporarily to `/tmp` rather than API server. Observe what stays available and what scheduling symptom appears. Restore immediately.
2. Create a one-page “API is down” node-local checklist from this lab.

## Cleanup / reset

1. Delete the namespace/resources created for this lab unless the next lab reuses them.
2. Return any node labels/taints/configuration changed only for this exercise to the baseline state.
3. Run `kubectl get nodes` and confirm the cluster is healthy.

## Debrief

Answer these in your error log or notes:

1. Why did kubectl become useless while kubelet/CRI evidence remained useful?
2. What directory behaviour makes backup files dangerous there?
3. How would scheduler failure symptoms differ from API server failure?

## Solution

Do not open it until you have either completed the lab or spent the full timebox using official documentation: [`../../solutions/lab-44-incident-control-plane-static-pod-failure.md`](../../solutions/lab-44-incident-control-plane-static-pod-failure.md).
