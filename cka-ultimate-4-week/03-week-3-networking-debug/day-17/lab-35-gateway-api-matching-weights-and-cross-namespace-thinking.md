# Lab 35 — Gateway API: Matching, Weights and Cross-Namespace Thinking

**Day:** 17  
**Primary domain:** Services & Networking  
**Timebox:** 35–50 min  
**Environment:** Healthy multi-node kubeadm cluster  
**Mode:** Hands-on

## Objective

- Use HTTPRoute rules/matches.
- Configure weighted backends conceptually/live.
- Understand cross-namespace reference permission.

## Scenario

A gateway must split `/v1` traffic 80/20 between two Services while rejecting an unauthorized cross-namespace backend reference.

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

1. In `cka-gateway`, create Deployments/Services `v1-a` and `v1-b` with distinguishable responses if practical.
2. Create/update HTTPRoute matching path prefix `/v1` with backendRefs weights 80 and 20. Inspect rendered YAML/status.
3. If a live controller is available, send at least 30 requests and observe approximate distribution; do not expect exact 24/6.
4. Create namespace `cka-backend` and Service `external-backend`. Attempt a route backendRef to that namespace without permission; inspect status.
5. Read current `ReferenceGrant` docs, create the minimum grant allowing the intended cross-namespace reference, and observe status transition where supported.

## Success criteria

- Weighted route uses correct backendRefs/weights.
- You understand weights are proportional, not deterministic sequence guarantees.
- Cross-namespace reference requires explicit permission where the API demands it.

## Verification

Run these (or an equivalent proof) and explain why each result proves the requirement:

```bash
kubectl get httproute -n cka-gateway -o yaml
kubectl describe httproute -n cka-gateway
kubectl get referencegrant -n cka-backend 2>/dev/null || true
```

## Documentation drill

Without using the solution file, find the relevant upstream documentation for **Gateway API HTTPRoute matching, traffic splitting and ReferenceGrant**. Locate the exact field/command you would need if the task wording changed. Time the lookup; target **under 2 minutes** by Week 4.

## Failure injection / stretch

1. Add a header match and reason about rule precedence using current docs.
2. Create a ReferenceGrant that is intentionally too broad, then narrow it to the minimum resource kind/source namespace needed.

## Cleanup / reset

1. Delete the namespace/resources created for this lab unless the next lab reuses them.
2. Return any node labels/taints/configuration changed only for this exercise to the baseline state.
3. Run `kubectl get nodes` and confirm the cluster is healthy.

## Debrief

Answer these in your error log or notes:

1. What does an HTTPRoute weight mean?
2. Why does target namespace control cross-namespace permission?
3. Which status condition would you inspect for a bad backend reference?

## Solution

Do not open it until you have either completed the lab or spent the full timebox using official documentation: [`../../solutions/lab-35-gateway-api-matching-weights-and-cross-namespace-thinking.md`](../../solutions/lab-35-gateway-api-matching-weights-and-cross-namespace-thinking.md).
