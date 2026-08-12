# Lab 47 — Exam-Style SSH Host and Context Drill

**Day:** 22  
**Primary domain:** Exam execution  
**Timebox:** 30–45 min  
**Environment:** Optional cka-shell plus direct SSH to cluster nodes  
**Mode:** Exam mechanics

## Objective

- Make designated-host workflow automatic.
- Prevent nested/wrong-host work.
- Preserve context/namespace/output discipline across task switches.

## Scenario

Exam tasks can tell you to SSH to a designated host. This drill simulates rapid context switching where the most dangerous mistake is solving correctly in the wrong place.

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

1. From `cka-shell` (or your workstation acting as jump host), create a printed task sheet containing six mini-tasks alternating between `controlplane`, `worker01`, and Kubernetes contexts/namespaces.
2. For each mini-task: read it, say target host/context/namespace aloud, SSH directly to named host if required, run `hostname` before any destructive command, complete one observation/change, save any requested output on the named host, then `exit`.
3. Include one node-local task (`systemctl is-active kubelet`), one control-plane file task (`ls /etc/kubernetes/manifests`), two kubectl namespace tasks, one output-file task and one harmless node label task.
4. After all six, audit shell histories/output locations and count any scope errors. Remove temporary label.
5. Repeat until zero scope errors under 15 minutes.

## Success criteria

- No nested SSH chain is needed.
- Every node-local command runs on the intended host.
- Every Kubernetes resource uses intended context/namespace.
- Requested output files live on intended host.

## Verification

Run these (or an equivalent proof) and explain why each result proves the requirement:

```bash
hostname
kubectl config current-context
kubectl config view --minify
kubectl get nodes
```

## Documentation drill

Without using the solution file, find the relevant upstream documentation for **Linux Foundation CKA Important Instructions: designated host workflow and task-host tools**. Locate the exact field/command you would need if the task wording changed. Time the lookup; target **under 2 minutes** by Week 4.

## Failure injection / stretch

1. Have someone reorder the task sheet after you start so you cannot rely on muscle-memory sequence.
2. Intentionally leave current namespace wrong between two tasks and prove your preflight catches it.

## Cleanup / reset

1. Delete the namespace/resources created for this lab unless the next lab reuses them.
2. Return any node labels/taints/configuration changed only for this exercise to the baseline state.
3. Run `kubectl get nodes` and confirm the cluster is healthy.

## Debrief

Answer these in your error log or notes:

1. What visual/command cue tells you which host you are on?
2. What is your fixed first command pair for every task?
3. Where can output-path requirements trip you up?

## Solution

Do not open it until you have either completed the lab or spent the full timebox using official documentation: [`../../solutions/lab-47-exam-style-ssh-host-and-context-drill.md`](../../solutions/lab-47-exam-style-ssh-host-and-context-drill.md).
