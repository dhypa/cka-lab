# Lab 34 — Gateway API: GatewayClass, Gateway and HTTPRoute

**Day:** 16  
**Primary domain:** Services & Networking  
**Timebox:** 35–50 min  
**Environment:** Healthy multi-node kubeadm cluster  
**Mode:** Hands-on

## Objective

- Author the core Gateway API resource chain.
- Inspect conditions/status rather than object existence.
- Route to a Service when a compatible controller exists.

## Scenario

The current CKA competencies include Gateway API. Build the `GatewayClass -> Gateway -> HTTPRoute -> Service` mental model and make status conditions part of normal debugging.

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

1. Read `assets/gateway/README.md`; confirm Gateway API CRDs and any GatewayClass/controller installed. If APIs are absent, install CRDs from current official Gateway API docs.
2. Create namespace `cka-gateway` with Deployment/Service `web`.
3. If a usable GatewayClass exists, create Gateway `web-gw` with HTTP listener port 80 using it. Otherwise use a placeholder class only for API-validation practice and clearly mark data-plane verification N/A.
4. Create HTTPRoute `web-route` parented to the Gateway and forwarding `/` to Service `web` port 80.
5. Inspect `kubectl describe`/status conditions for Gateway and HTTPRoute. If a controller exists, perform an HTTP request through the Gateway address.

## Success criteria

- Gateway API objects validate against installed CRDs.
- Parent and backend references are correct.
- You can explain Accepted/Programmed/resolved-reference status evidence observed in your implementation.

## Verification

Run these (or an equivalent proof) and explain why each result proves the requirement:

```bash
kubectl get gatewayclass
kubectl get gateway -n cka-gateway -o yaml
kubectl get httproute -n cka-gateway -o yaml
kubectl describe httproute web-route -n cka-gateway
```

## Documentation drill

Without using the solution file, find the relevant upstream documentation for **Gateway API concepts, GatewayClass, Gateway and HTTPRoute**. Locate the exact field/command you would need if the task wording changed. Time the lookup; target **under 2 minutes** by Week 4.

## Failure injection / stretch

1. Set backend port to a nonexistent Service port and inspect route conditions/events/controller output; repair it.
2. Add hostname matching and test Host header behaviour on a live controller.

## Cleanup / reset

1. Delete the namespace/resources created for this lab unless the next lab reuses them.
2. Return any node labels/taints/configuration changed only for this exercise to the baseline state.
3. Run `kubectl get nodes` and confirm the cluster is healthy.

## Debrief

Answer these in your error log or notes:

1. Which resource represents infrastructure/controller class?
2. Which object owns listeners?
3. Why is resource creation insufficient proof of traffic programming?

## Solution

Do not open it until you have either completed the lab or spent the full timebox using official documentation: [`../../solutions/lab-34-gateway-api-gatewayclass-gateway-and-httproute.md`](../../solutions/lab-34-gateway-api-gatewayclass-gateway-and-httproute.md).
