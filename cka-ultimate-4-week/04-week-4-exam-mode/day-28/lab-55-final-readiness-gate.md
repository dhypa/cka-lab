# Lab 55 — Final Readiness Gate

**Day:** 28  
**Primary domain:** All domains / Exam execution  
**Timebox:** 120–150 min  
**Environment:** Healthy multi-node kubeadm cluster  
**Mode:** Readiness gate

## Objective

- Make a go/no-go assessment from evidence.
- Run final high-risk skill spot checks.
- Lock exam routine rather than cramming new topics.

## Scenario

Day 28 is not for consuming another course. It is for proving the current blueprint has no untrained hole and that your execution is stable.

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

1. Re-rate every row in `00-course/skill-matrix.md`. Any Red official-domain skill automatically fails readiness and gets a targeted lab repeat.
2. Review both mock scorecards. Course target: ≥75/100 on both timed mocks **and** no repeated scope error. If not met, identify exact additional practice rather than lowering the bar.
3. Run six cold spot checks, max 10 minutes each: RBAC positive/negative; Service+EndpointSlice repair; NetworkPolicy allow/deny; etcd snapshot inputs/status; worker NotReady diagnostic path (can be simulated without breaking if needed); Helm or Kustomize change+verification.
4. Run `scripts/cluster-health.sh`; return every shared component/node to healthy baseline.
5. Read `reference/exam-day-checklist.md` and current official Important Instructions/allowed resources once. Write your fixed task routine on one line: scope → solve → verify → mark/skip.
6. Stop adding new resources. Sleep/rest and schedule exam-day logistics according to your actual booking.

## Success criteria

- No Red official-domain skills.
- Both internal timed mocks meet 75/100 course target or there is an explicit decision to extend preparation.
- Six cold spot checks complete within 60 minutes total.
- No unresolved cluster damage.
- Exam routine and current rules are known.

## Verification

Run these (or an equivalent proof) and explain why each result proves the requirement:

```bash
bash scripts/cluster-health.sh
grep -n "Mock" 00-course/progress.md
grep -n "|.*R" 00-course/skill-matrix.md || true
```

## Documentation drill

Without using the solution file, find the relevant upstream documentation for **Current CKA certification page, Important Instructions, allowed resources and only the official docs for any remaining Red/Amber skill**. Locate the exact field/command you would need if the task wording changed. Time the lookup; target **under 2 minutes** by Week 4.

## Failure injection / stretch

1. On a separate day before the exam, do a 20-minute warm-up containing one YAML generation, one `auth can-i`, one EndpointSlice check and one node-status check—then stop.
2. If a blueprint/exam-version change is announced after this course build, diff the official competencies against `exam-blueprint.md` and add only the missing practice.

## Cleanup / reset

1. Delete the namespace/resources created for this lab unless the next lab reuses them.
2. Return any node labels/taints/configuration changed only for this exercise to the baseline state.
3. Run `kubectl get nodes` and confirm the cluster is healthy.

## Debrief

Answer these in your error log or notes:

1. What is your weakest remaining domain by evidence?
2. What mistake is most likely under stress and what guardrail catches it?
3. What is the first thing you will do on every real exam task?

## Solution

Do not open it until you have either completed the lab or spent the full timebox using official documentation: [`../../solutions/lab-55-final-readiness-gate.md`](../../solutions/lab-55-final-readiness-gate.md).
