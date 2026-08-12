# Lab 43 — Incident: Worker Node NotReady

**Day:** 20  
**Primary domain:** Troubleshooting  
**Timebox:** 45–60 min  
**Environment:** Healthy multi-node kubeadm cluster  
**Mode:** Incident

## Objective

- Diagnose a NotReady worker from cluster and node evidence.
- Use systemd/journal/runtime checks.
- Restore node and validate workloads.

## Scenario

worker02 turns NotReady. The API still works from controlplane. You must identify whether kubelet, runtime, disk/resources or networking is the immediate cause.

## Prerequisites

- A healthy practice cluster and working `kubectl`.

## Safety / starting-state check

> Intentionally makes worker02 NotReady. Snapshot first and verify the SSH hostname before stopping services.

Run and read the output before proceeding:

```bash
hostname
kubectl config current-context
kubectl get nodes -o wide
```

## Lab setup

1. Create any named namespace/resources only when instructed. Do not reuse leftovers from a previous attempt.

## Tasks

1. Take a worker02 snapshot. Schedule/identify a disposable workload on worker02.
2. On worker02, stop kubelet: `sudo systemctl stop kubelet`. Do not write “kubelet stopped” in your incident notes.
3. Return to controlplane and wait for node condition to reflect loss of heartbeat. Set a 25-minute timer.
4. Inspect Node conditions/events/leases and workloads; SSH to worker02 and inspect systemctl/journal plus container runtime.
5. Restore the actual failed service, wait for Ready and prove a workload runs.
6. Repeat on a later attempt with containerd stopped instead; compare evidence.

## Success criteria

- Node transitions back to Ready.
- kubelet and container runtime are active on worker02.
- Your notes distinguish cluster-observed symptoms from node-local cause.

## Verification

Run these (or an equivalent proof) and explain why each result proves the requirement:

```bash
kubectl get node worker02
kubectl describe node worker02 | tail -60
ssh worker02 "systemctl is-active kubelet && systemctl is-active containerd"
kubectl get pods -A -o wide --field-selector spec.nodeName=worker02
```

## Documentation drill

Without using the solution file, find the relevant upstream documentation for **troubleshooting nodes, kubelet logs and node conditions**. Locate the exact field/command you would need if the task wording changed. Time the lookup; target **under 2 minutes** by Week 4.

## Failure injection / stretch

1. Compare a stopped kubelet with disk-pressure/read-only scenarios from docs and list evidence you would seek.
2. Inspect the Node Lease object update time before/after recovery.

## Cleanup / reset

1. Delete the namespace/resources created for this lab unless the next lab reuses them.
2. Return any node labels/taints/configuration changed only for this exercise to the baseline state.
3. Run `kubectl get nodes` and confirm the cluster is healthy.

## Debrief

Answer these in your error log or notes:

1. What evidence is available even when kubelet is down?
2. How does stopped runtime differ from stopped kubelet?
3. Which node condition/event timestamps help build a timeline?

## Solution

Do not open it until you have either completed the lab or spent the full timebox using official documentation: [`../../solutions/lab-43-incident-worker-node-notready.md`](../../solutions/lab-43-incident-worker-node-notready.md).
