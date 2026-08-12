# Lab 31 — Pod-to-Pod and Service Network Path

**Day:** 15  
**Primary domain:** Services & Networking / Troubleshooting  
**Timebox:** 35–50 min  
**Environment:** Healthy multi-node kubeadm cluster  
**Mode:** Hands-on

## Objective

- Trace traffic across Pod IP and Service IP paths.
- Use source/destination evidence to isolate network layers.
- Build a repeatable connectivity matrix.

## Scenario

A service is intermittently reported unreachable. Before changing policy or DNS, establish whether direct Pod networking and Service forwarding actually work.

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

1. Create namespace `cka-net`; Deployment `echo` with 2 nginx replicas and Service `echo` port 80. Ensure replicas land on multiple workers if possible.
2. Create client Pod `net-client` using BusyBox. Record client Pod IP/node, backend Pod IPs/nodes, Service ClusterIP and EndpointSlice addresses.
3. From client, reach each backend Pod IP directly and then reach Service ClusterIP/name.
4. Delete one backend Pod and watch EndpointSlice/controller convergence; repeat Service request.
5. Write `/tmp/network-matrix.txt` with source, destination type, address/name, success/failure and implicated layer.

## Success criteria

- Direct Pod-IP connectivity works across nodes in a healthy CNI.
- Service path works through ClusterIP/name.
- EndpointSlice updates when backend changes.

## Verification

Run these (or an equivalent proof) and explain why each result proves the requirement:

```bash
kubectl get po -n cka-net -o wide
kubectl get svc echo -n cka-net -o wide
kubectl get endpointslice -n cka-net -l kubernetes.io/service-name=echo -o wide
cat /tmp/network-matrix.txt
```

## Documentation drill

Without using the solution file, find the relevant upstream documentation for **Kubernetes networking model, Services and EndpointSlices**. Locate the exact field/command you would need if the task wording changed. Time the lookup; target **under 2 minutes** by Week 4.

## Failure injection / stretch

1. Temporarily make Service targetPort wrong. Which tests still succeed? Use the matrix to identify the failing layer.
2. Inspect node-level service implementation evidence appropriate to your cluster (kube-proxy or alternative) without changing it.

## Cleanup / reset

1. Delete the namespace/resources created for this lab unless the next lab reuses them.
2. Return any node labels/taints/configuration changed only for this exercise to the baseline state.
3. Run `kubectl get nodes` and confirm the cluster is healthy.

## Debrief

Answer these in your error log or notes:

1. Which test bypasses Service routing?
2. What evidence shows the Service controller found backends?
3. How do you distinguish CNI versus Service implementation failure?

## Solution

Do not open it until you have either completed the lab or spent the full timebox using official documentation: [`../../solutions/lab-31-pod-to-pod-and-service-network-path.md`](../../solutions/lab-31-pod-to-pod-and-service-network-path.md).
