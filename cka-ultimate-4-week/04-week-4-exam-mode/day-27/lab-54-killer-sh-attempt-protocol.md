# Lab 54 — Killer.sh Attempt Protocol

**Day:** 27  
**Primary domain:** Exam execution / All domains  
**Timebox:** Simulator session + remediation  
**Environment:** Healthy multi-node kubeadm cluster  
**Mode:** Official simulator protocol

## Objective

- Use the official simulator as a diagnostic tool.
- Preserve first-attempt signal.
- Convert simulator misses into focused course repeats.

## Scenario

The CKA purchase currently includes simulator attempts. Their value is highest when treated like exams rather than as a question bank to memorise.

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

1. Before starting an available simulator session, re-check the current Linux Foundation entitlement/instructions and simulator time/access details. Use a healthy snapshot and close this course’s solution files.
2. Run the simulator in one uninterrupted attempt under its intended timing/environment. Use only permitted resources for that environment.
3. Record task categories, not copied proprietary task wording: e.g. “etcd restore”, “NetworkPolicy selector”, “kubelet diagnosis”.
4. After the attempt, classify every miss/slow task and map it to the closest labs in this repository. Repeat those labs from blank state.
5. Use a second simulator attempt only after remediation; avoid spending it immediately to see the same weaknesses again.
6. If you do not have simulator access today, run `mocks/mock-02.md` under 120 minutes using the same protocol.

## Success criteria

- Simulator/mock attempt is uninterrupted and honestly scored.
- No live/proprietary questions are copied into this repository.
- Each weak category maps to a concrete lab repeat.

## Verification

Run these (or an equivalent proof) and explain why each result proves the requirement:

```bash
kubectl get nodes
test -f /tmp/remediation26.txt && tail -20 /tmp/remediation26.txt || true
```

## Documentation drill

Without using the solution file, find the relevant upstream documentation for **Current Linux Foundation CKA certification/simulator instructions**. Locate the exact field/command you would need if the task wording changed. Time the lookup; target **under 2 minutes** by Week 4.

## Failure injection / stretch

1. Build a 30-minute micro-circuit from your three worst categories and repeat tomorrow morning.
2. Compare error taxonomy between Mock 1 and simulator/Mock 2.

## Cleanup / reset

1. Delete the namespace/resources created for this lab unless the next lab reuses them.
2. Return any node labels/taints/configuration changed only for this exercise to the baseline state.
3. Run `kubectl get nodes` and confirm the cluster is healthy.

## Debrief

Answer these in your error log or notes:

1. Which category remained weak after Mock 1 remediation?
2. Did time pressure or technical skill dominate?
3. What must be Green before the real exam?

## Solution

Do not open it until you have either completed the lab or spent the full timebox using official documentation: [`../../solutions/lab-54-killer-sh-attempt-protocol.md`](../../solutions/lab-54-killer-sh-attempt-protocol.md).
