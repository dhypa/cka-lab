# Lab 48 — Timed Networking Circuit

**Day:** 23  
**Primary domain:** Services & Networking / Troubleshooting  
**Timebox:** 35 min  
**Environment:** Healthy multi-node kubeadm cluster  
**Mode:** Timed circuit

## Objective

- Solve Service/DNS/NetworkPolicy/Gateway-style tasks under time pressure.
- Choose evidence quickly.
- Preserve intended denied paths while restoring allowed paths.

## Scenario

This is a 35-minute networking mini-exam. Do not open reference files until a lookup is genuinely needed.

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

1. In namespace `cka-net-speed`, create Deployment `api` 2 replicas and ClusterIP Service port 8080→80. Prove HTTP.
2. Apply ingress default-deny, then allow only Pods labelled `role=frontend` to TCP/80 backend Pods. Create allowed/denied clients and prove both outcomes.
3. Break Service selector, diagnose using EndpointSlice and repair.
4. From a client, resolve full Service FQDN and save resolution output to `/tmp/cka-dns.txt`.
5. If Gateway API CRDs exist, author an HTTPRoute `/api` to the Service under an existing/placeholder Gateway and inspect status. If API absent, spend at most 3 minutes documenting the exact official page/installation prerequisite and move on.
6. Finish with exact Service selector/ports, positive/negative policy proof and no accidental open access.

## Success criteria

- Core Service request works.
- Policy allows only intended client.
- Selector fault is found/repaired from endpoint evidence.
- DNS output file exists.
- Gateway branch is correctly scoped to installed capabilities.

## Verification

Run these (or an equivalent proof) and explain why each result proves the requirement:

```bash
kubectl get svc,endpointslice,netpol -n cka-net-speed -o wide
cat /tmp/cka-dns.txt
kubectl get gateway,httproute -n cka-net-speed 2>/dev/null || true
```

## Documentation drill

Without using the solution file, find the relevant upstream documentation for **Service, NetworkPolicy, DNS and Gateway API quick references**. Locate the exact field/command you would need if the task wording changed. Time the lookup; target **under 2 minutes** by Week 4.

## Failure injection / stretch

1. Reset and rerun in 25 minutes.
2. Replace selector fault with wrong targetPort and explain why EndpointSlice evidence differs.

## Cleanup / reset

1. Delete the namespace/resources created for this lab unless the next lab reuses them.
2. Return any node labels/taints/configuration changed only for this exercise to the baseline state.
3. Run `kubectl get nodes` and confirm the cluster is healthy.

## Debrief

Answer these in your error log or notes:

1. Which networking layer did you inspect first for the injected fault?
2. How long did policy syntax take to retrieve?
3. Could you prove the denied path as quickly as the allowed path?

## Solution

Do not open it until you have either completed the lab or spent the full timebox using official documentation: [`../../solutions/lab-48-timed-networking-circuit.md`](../../solutions/lab-48-timed-networking-circuit.md).
