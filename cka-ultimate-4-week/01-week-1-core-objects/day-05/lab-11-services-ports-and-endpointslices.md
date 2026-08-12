# Lab 11 — Services, Ports and EndpointSlices

**Day:** 5  
**Primary domain:** Services & Networking / Troubleshooting  
**Timebox:** 35–50 min  
**Environment:** Healthy multi-node kubeadm cluster  
**Mode:** Hands-on

## Objective

- Create and repair ClusterIP/NodePort Services.
- Map Service `port` to backend `targetPort`.
- Use EndpointSlices to prove selector/backend state.

## Scenario

A Deployment is healthy but users cannot reach it through its Service. You need to trace selectors and ports rather than restart random Pods.

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

1. Create namespace `cka-net`; create Deployment `web80` with 2 nginx replicas on container port 80.
2. Create Service `web80` with port 8080 but intentionally set `targetPort: 8081`.
3. Inspect Service, Pod labels and EndpointSlice; explain why endpoints can exist even though traffic fails due to wrong backend port.
4. From a disposable client Pod, test Service DNS/port and capture failure. Repair targetPort to 80 and prove HTTP succeeds.
5. Change Service type to NodePort, identify allocated nodePort, then revert to ClusterIP or delete it.

## Success criteria

- EndpointSlice contains the web Pod addresses.
- HTTP through Service port 8080 succeeds only after targetPort repair.
- You can state the difference between `port`, `targetPort`, and `nodePort`.

## Verification

Run these (or an equivalent proof) and explain why each result proves the requirement:

```bash
kubectl get svc web80 -n cka-net -o wide
kubectl get endpointslice -n cka-net -l kubernetes.io/service-name=web80 -o wide
kubectl run netcheck -n cka-net --rm -i --restart=Never --image=busybox:1.36 -- wget -qO- http://web80:8080
```

## Documentation drill

Without using the solution file, find the relevant upstream documentation for **Service types, ports and EndpointSlices**. Locate the exact field/command you would need if the task wording changed. Time the lookup; target **under 2 minutes** by Week 4.

## Failure injection / stretch

1. Change the Service selector to a non-matching label and compare that failure evidence with the wrong-targetPort case.
2. Create a selector-less Service and manually managed EndpointSlice after reading the relevant docs.

## Cleanup / reset

1. Delete the namespace/resources created for this lab unless the next lab reuses them.
2. Return any node labels/taints/configuration changed only for this exercise to the baseline state.
3. Run `kubectl get nodes` and confirm the cluster is healthy.

## Debrief

Answer these in your error log or notes:

1. What produces EndpointSlices for selector-based Services?
2. Can a Service have endpoints and still fail? Give two reasons.
3. When would NodePort be relevant?

## Solution

Do not open it until you have either completed the lab or spent the full timebox using official documentation: [`../../solutions/lab-11-services-ports-and-endpointslices.md`](../../solutions/lab-11-services-ports-and-endpointslices.md).
