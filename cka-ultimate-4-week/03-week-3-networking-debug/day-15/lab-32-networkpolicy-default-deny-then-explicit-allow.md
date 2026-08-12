# Lab 32 — NetworkPolicy: Default Deny then Explicit Allow

**Day:** 15  
**Primary domain:** Services & Networking  
**Timebox:** 35–50 min  
**Environment:** Healthy multi-node kubeadm cluster  
**Mode:** Hands-on

## Objective

- Apply default-deny ingress.
- Permit traffic by Pod selector and port.
- Verify both allowed and denied paths.

## Scenario

The `api` workload should accept TCP/80 only from Pods explicitly labelled `access=allowed`. Every other Pod in the namespace should be blocked.

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

1. Apply/adapt `assets/networkpolicy-seed.yaml`. First prove both clients can reach Service `api`.
2. Create default-deny ingress NetworkPolicy selecting all Pods in `cka-net`. Verify both clients are now blocked.
3. Create a policy selecting `app=api` that permits ingress TCP/80 only from Pods with `access=allowed`.
4. Prove `client-allowed` succeeds and `client-denied` times out/fails.
5. Inspect policy selectors and backend labels; explain additive policy semantics.

## Success criteria

- Baseline is proven before policy.
- Denied client cannot establish the connection while allowed client can.
- CNI in use is confirmed to enforce NetworkPolicy.

## Verification

Run these (or an equivalent proof) and explain why each result proves the requirement:

```bash
kubectl get networkpolicy -n cka-net -o yaml
kubectl exec -n cka-net client-allowed -- wget -T 3 -qO- http://api
kubectl exec -n cka-net client-denied -- wget -T 3 -qO- http://api || echo expected-deny
```

## Documentation drill

Without using the solution file, find the relevant upstream documentation for **NetworkPolicy selectors, default deny and policy behaviour**. Locate the exact field/command you would need if the task wording changed. Time the lookup; target **under 2 minutes** by Week 4.

## Failure injection / stretch

1. Permit traffic from a labelled namespace plus a Pod selector; ensure you understand whether selectors are ANDed in the same `from` element or ORed across elements.
2. Add egress default-deny on a disposable client and explicitly allow DNS plus API traffic.

## Cleanup / reset

1. Delete the namespace/resources created for this lab unless the next lab reuses them.
2. Return any node labels/taints/configuration changed only for this exercise to the baseline state.
3. Run `kubectl get nodes` and confirm the cluster is healthy.

## Debrief

Answer these in your error log or notes:

1. When does a Pod become isolated for ingress?
2. Are multiple matching policies additive or first-match?
3. How can you prove a policy problem rather than a DNS problem?

## Solution

Do not open it until you have either completed the lab or spent the full timebox using official documentation: [`../../solutions/lab-32-networkpolicy-default-deny-then-explicit-allow.md`](../../solutions/lab-32-networkpolicy-default-deny-then-explicit-allow.md).
