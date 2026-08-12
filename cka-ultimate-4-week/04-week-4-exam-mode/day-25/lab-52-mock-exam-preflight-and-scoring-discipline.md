# Lab 52 — Mock Exam Preflight and Scoring Discipline

**Day:** 25  
**Primary domain:** Exam execution  
**Timebox:** 140–160 min including scoring  
**Environment:** Healthy multi-node kubeadm cluster  
**Mode:** Mock protocol

## Objective

- Prepare a repeatable 120-minute mock protocol.
- Score objective end state instead of effort.
- Practise skipping and review strategy.

## Scenario

A mock only predicts readiness if you simulate time pressure, scope constraints, documentation rules and verification rather than pausing for tutorials.

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

1. Read `mocks/README.md` and print/open `mock-01.md` without solutions. Reset the practice namespaces and confirm healthy cluster/snapshot.
2. Set exactly 120 minutes. Keep only allowed-style official docs available. Do not pause timer for interruptions or research.
3. Use three passes: harvest, deliberate, verify. Record task start/end/skip marks on `mocks/mock-01-scorecard.md`.
4. At 120 minutes stop making changes. Run scorecard verification and award points only for satisfied requirements. Partial points are permitted only where scorecard says so.
5. Write the top five misses by taxonomy into error log. Do not begin remediation in this lab.

## Success criteria

- Mock is completed under uninterrupted 120-minute timer.
- Raw score is reproducible from verification evidence.
- Every missed task has a classified cause.

## Verification

Run these (or an equivalent proof) and explain why each result proves the requirement:

```bash
kubectl get nodes
grep -n "Task" mocks/mock-01-scorecard.md | head
```

## Documentation drill

Without using the solution file, find the relevant upstream documentation for **Linux Foundation Important Instructions, allowed resources and exam UI**. Locate the exact field/command you would need if the task wording changed. Time the lookup; target **under 2 minutes** by Week 4.

## Failure injection / stretch

1. Repeat the preflight steps before Mock 2 without rereading this lab.
2. Calculate points-per-minute lost to each error category.

## Cleanup / reset

1. Delete the namespace/resources created for this lab unless the next lab reuses them.
2. Return any node labels/taints/configuration changed only for this exercise to the baseline state.
3. Run `kubectl get nodes` and confirm the cluster is healthy.

## Debrief

Answer these in your error log or notes:

1. What did you skip and return to successfully?
2. How many points were lost to scope/syntax versus knowledge?
3. How much review time remained?

## Solution

Do not open it until you have either completed the lab or spent the full timebox using official documentation: [`../../solutions/lab-52-mock-exam-preflight-and-scoring-discipline.md`](../../solutions/lab-52-mock-exam-preflight-and-scoring-discipline.md).
