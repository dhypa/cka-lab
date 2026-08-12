# Lab 53 — Mock 1 Remediation Laboratory

**Day:** 26  
**Primary domain:** All domains  
**Timebox:** 120–180 min  
**Environment:** Healthy multi-node kubeadm cluster  
**Mode:** Remediation

## Objective

- Turn every mock miss into a repeatable skill.
- Separate knowledge gaps from speed/scope/verification errors.
- Require two clean repetitions before declaring fixed.

## Scenario

The day after a mock is not “review answers”; it is targeted retraining based on evidence.

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

1. Read Mock 1 scorecard and error log. Rank missed/slow tasks by points lost, then by recurrence.
2. For each miss, write the minimal skill statement, e.g. “bind ClusterRole to ServiceAccount and prove negative namespace access,” not “RBAC bad”.
3. Rebuild the relevant object/problem from a blank namespace/node state **without** using the mock solution. Use official docs as needed.
4. After first correct completion, reset it and repeat from terse wording with a tighter timebox and no notes.
5. Open `mocks/mock-01-solutions.md` only after your independent repair; compare for missed edge cases/verification.
6. Update skill matrix Red/Amber/Green only after two correct runs. Create `/tmp/remediation26.txt` listing original task, root error tag, first time, second time, final status.

## Success criteria

- Every missed task has two successful post-mock repetitions or remains explicitly Amber/Red.
- Remediation file records measurable improvement.
- No skill is marked Green based only on reading a solution.

## Verification

Run these (or an equivalent proof) and explain why each result proves the requirement:

```bash
cat /tmp/remediation26.txt
kubectl get nodes
```

## Documentation drill

Without using the solution file, find the relevant upstream documentation for **Use the official documentation page corresponding to each individual miss**. Locate the exact field/command you would need if the task wording changed. Time the lookup; target **under 2 minutes** by Week 4.

## Failure injection / stretch

1. Take the three slowest correct Mock 1 tasks and remediate speed too.
2. Rewrite one missed mock task into a different scenario requiring same underlying skill; solve it.

## Cleanup / reset

1. Delete the namespace/resources created for this lab unless the next lab reuses them.
2. Return any node labels/taints/configuration changed only for this exercise to the baseline state.
3. Run `kubectl get nodes` and confirm the cluster is healthy.

## Debrief

Answer these in your error log or notes:

1. What percentage of lost points were knowledge versus execution?
2. Which error tag dominates?
3. What will you deliberately change in Mock 2 strategy?

## Solution

Do not open it until you have either completed the lab or spent the full timebox using official documentation: [`../../solutions/lab-53-mock-1-remediation-laboratory.md`](../../solutions/lab-53-mock-1-remediation-laboratory.md).
