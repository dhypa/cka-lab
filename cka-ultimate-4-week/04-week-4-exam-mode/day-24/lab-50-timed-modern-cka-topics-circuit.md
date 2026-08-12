# Lab 50 — Timed Modern CKA Topics Circuit

**Day:** 24  
**Primary domain:** Cluster Architecture / Networking / Workloads  
**Timebox:** 45 min  
**Environment:** Healthy multi-node kubeadm cluster  
**Mode:** Timed circuit

## Objective

- Exercise Helm, Kustomize, CRD, HPA and Gateway API in one circuit.
- Recognise prerequisite-dependent tasks quickly.
- Retrieve modern API syntax from official docs.

## Scenario

Older study plans often omit current explicit competencies. This circuit prevents those topics becoming last-minute surprises.

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

1. Start a 45-minute timer. Helm: install local `cka-web` chart release `modern`, upgrade replicas to 3, inspect history.
2. Kustomize: render prod overlay, change an overlay-only property, diff/apply and verify.
3. CRD: apply Widget CRD, create one valid Widget and prove one invalid object is rejected.
4. HPA: create or verify an HPA on a CPU-requested Deployment; if metrics API absent, inspect status and write the missing prerequisite rather than spending the circuit installing a stack.
5. Gateway API: author/inspect Gateway+HTTPRoute using installed class if available; otherwise create syntactically valid resources only where CRDs exist and document missing controller/class.
6. End by writing one command per topic to `/tmp/modern-commands.txt` that gets the highest-signal status/history.

## Success criteria

- All installed-capability branches complete correctly.
- You do not confuse API-object validation with controller functionality.
- Helm/Kustomize/CRD commands require little lookup.

## Verification

Run these (or an equivalent proof) and explain why each result proves the requirement:

```bash
helm list -A
kubectl get crd widgets.training.cka.io
kubectl get hpa -A 2>/dev/null || true
kubectl get gatewayclass 2>/dev/null || true
cat /tmp/modern-commands.txt
```

## Documentation drill

Without using the solution file, find the relevant upstream documentation for **Helm, Kustomize, CRDs, HPA and Gateway API**. Locate the exact field/command you would need if the task wording changed. Time the lookup; target **under 2 minutes** by Week 4.

## Failure injection / stretch

1. Reset and rerun in 35 minutes.
2. For each topic, name one status/verification command that is stronger than “object exists”.

## Cleanup / reset

1. Delete the namespace/resources created for this lab unless the next lab reuses them.
2. Return any node labels/taints/configuration changed only for this exercise to the baseline state.
3. Run `kubectl get nodes` and confirm the cluster is healthy.

## Debrief

Answer these in your error log or notes:

1. Which modern topic is slowest?
2. What prerequisite can make HPA/Gateway live verification impossible?
3. What one docs page should you be able to find fastest for each?

## Solution

Do not open it until you have either completed the lab or spent the full timebox using official documentation: [`../../solutions/lab-50-timed-modern-cka-topics-circuit.md`](../../solutions/lab-50-timed-modern-cka-topics-circuit.md).
