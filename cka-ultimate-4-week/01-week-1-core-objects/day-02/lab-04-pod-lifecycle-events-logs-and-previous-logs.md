# Lab 04 — Pod Lifecycle, Events, Logs and Previous Logs

**Day:** 2  
**Primary domain:** Troubleshooting  
**Timebox:** 35–50 min  
**Environment:** Healthy multi-node kubeadm cluster  
**Mode:** Hands-on

## Objective

- Use Pod phase, container state, events and logs together.
- Retrieve logs from the previously crashed container instance.
- Separate scheduling, startup and runtime failures.

## Scenario

An application Pod restarts repeatedly. You are on call and must produce evidence for whether the problem is Kubernetes scheduling, image/startup, or the application process itself.

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

1. Create namespace `cka-debug` and Pod `crasher` using `busybox:1.36` whose command prints `starting`, sleeps 2 seconds, prints `boom`, and exits 1. Set `restartPolicy: Always`.
2. Observe `kubectl get pod -w` until at least one restart occurs.
3. Use `describe` and sorted events to identify state, reason, restart count and back-off behaviour.
4. Capture current logs and `--previous` logs to separate files under `/tmp`.
5. Change the command so it sleeps successfully and prove the restart count stops increasing.

## Success criteria

- You can point to at least one event and one container-status field explaining the failure.
- `/tmp/crasher-previous.log` contains output from a prior instance.
- After repair, the Pod stays Running without new restarts for at least 30 seconds.

## Verification

Run these (or an equivalent proof) and explain why each result proves the requirement:

```bash
kubectl get pod crasher -n cka-debug -o wide
kubectl describe pod crasher -n cka-debug | tail -40
kubectl logs crasher -n cka-debug --previous || true
kubectl get events -n cka-debug --sort-by=.lastTimestamp | tail -20
```

## Documentation drill

Without using the solution file, find the relevant upstream documentation for **Pod lifecycle, container states, `kubectl logs --previous`, and events**. Locate the exact field/command you would need if the task wording changed. Time the lookup; target **under 2 minutes** by Week 4.

## Failure injection / stretch

1. Create a second Pod with an invalid image tag. Compare `ImagePullBackOff` evidence with the runtime crash.
2. Write a three-line diagnostic rule for `Pending`, `ImagePullBackOff`, and `CrashLoopBackOff`.

## Cleanup / reset

1. Delete the namespace/resources created for this lab unless the next lab reuses them.
2. Return any node labels/taints/configuration changed only for this exercise to the baseline state.
3. Run `kubectl get nodes` and confirm the cluster is healthy.

## Debrief

Answer these in your error log or notes:

1. Why can Pod phase and container state tell different stories?
2. Which evidence would distinguish a scheduler failure from an application crash?
3. When are events more useful than logs?

## Solution

Do not open it until you have either completed the lab or spent the full timebox using official documentation: [`../../solutions/lab-04-pod-lifecycle-events-logs-and-previous-logs.md`](../../solutions/lab-04-pod-lifecycle-events-logs-and-previous-logs.md).
