# Lab 12 — CoreDNS and Service Discovery

**Day:** 5  
**Primary domain:** Services & Networking / Troubleshooting  
**Timebox:** 35–50 min  
**Environment:** Healthy multi-node kubeadm cluster  
**Mode:** Hands-on

## Objective

- Resolve Service names from Pods.
- Inspect CoreDNS health/configuration evidence.
- Distinguish DNS failure from Service/backend failure.

## Scenario

An application reports “host not found” for an internal Service. You must prove whether DNS, naming, namespace scope, or the Service itself is wrong.

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

1. Using the `web80` Service, start a disposable BusyBox Pod in `cka-net`. Resolve `web80`, `web80.cka-net`, and the full cluster Service name.
2. Start another client in `default`; show why bare `web80` does not refer to the Service in `cka-net`, then use the qualified name.
3. Inspect CoreDNS Pods and the `kube-dns` Service.
4. Read `/etc/resolv.conf` inside a client Pod and explain search domains and `ndots` at a high level.
5. Create a lookup for a deliberately nonexistent Service and compare NXDOMAIN/name failure with a resolvable Service whose backend port is broken.

## Success criteria

- Qualified Service DNS resolves from another namespace.
- CoreDNS Pods are healthy and reachable through their Service.
- You can distinguish resolution from transport/application reachability.

## Verification

Run these (or an equivalent proof) and explain why each result proves the requirement:

```bash
kubectl -n kube-system get pods -l k8s-app=kube-dns -o wide
kubectl -n kube-system get svc kube-dns
kubectl run dnscheck -n default --rm -i --restart=Never --image=busybox:1.36 -- nslookup web80.cka-net.svc.cluster.local
```

## Documentation drill

Without using the solution file, find the relevant upstream documentation for **DNS for Services and Pods; debugging DNS resolution**. Locate the exact field/command you would need if the task wording changed. Time the lookup; target **under 2 minutes** by Week 4.

## Failure injection / stretch

1. Temporarily scale CoreDNS down only if you have a snapshot and understand blast radius; observe DNS failure then restore immediately. Prefer this only on a dedicated lab cluster.
2. Inspect the CoreDNS ConfigMap and identify where the `kubernetes` plugin appears without modifying it.

## Cleanup / reset

1. Delete the namespace/resources created for this lab unless the next lab reuses them.
2. Return any node labels/taints/configuration changed only for this exercise to the baseline state.
3. Run `kubectl get nodes` and confirm the cluster is healthy.

## Debrief

Answer these in your error log or notes:

1. What does the namespace search domain buy you?
2. How would you prove CoreDNS works before blaming it?
3. Why should network debugging separate name resolution from TCP/HTTP reachability?

## Solution

Do not open it until you have either completed the lab or spent the full timebox using official documentation: [`../../solutions/lab-12-coredns-and-service-discovery.md`](../../solutions/lab-12-coredns-and-service-discovery.md).
