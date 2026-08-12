# Lab 17 — Build a Multi-Node Cluster with kubeadm

**Day:** 8  
**Primary domain:** Cluster Architecture, Installation & Configuration  
**Timebox:** 90–120 min  
**Environment:** Three clean Linux VMs with container runtime + Kubernetes packages installed  
**Mode:** Hands-on

## Objective

- Bootstrap a control plane with kubeadm.
- Install networking and join workers.
- Verify the cluster from component through Pod networking layers.

## Scenario

Rebuild your practice cluster from the clean-OS snapshot so you have personally performed the workflow that managed services normally hide.

## Prerequisites

- A healthy practice cluster and working `kubectl`.

## Safety / starting-state check

> This is a cluster rebuild. Use disposable VMs/snapshots and do not run kubeadm init/reset against a cluster you need to preserve.

Run and read the output before proceeding:

```bash
hostname
kubectl config current-context
kubectl get nodes -o wide
```

## Lab setup

1. Create any named namespace/resources only when instructed. Do not reuse leftovers from a previous attempt.

## Tasks

1. Restore the `00-clean-os` snapshot/clone on all three Kubernetes nodes. Confirm container runtime, kernel/network prerequisites and matching Kubernetes package minor are present.
2. On `controlplane`, run an appropriate `kubeadm init` command for your chosen CNI/pod CIDR requirements. Save the join command securely.
3. Configure the regular user kubeconfig from `/etc/kubernetes/admin.conf`.
4. Install one CNI using its **current official install instructions**; wait for control-plane networking/DNS prerequisites to settle.
5. Join `worker01` and `worker02`.
6. Verify all nodes Ready, system Pods healthy, and a test Pod can resolve a Service and communicate across nodes. Take snapshot `10-cluster-ready`.

## Success criteria

- Three nodes are Ready.
- CoreDNS and CNI components are healthy.
- At least one cross-node workload connectivity test succeeds.
- You can reproduce the join command without re-running init.

## Verification

Run these (or an equivalent proof) and explain why each result proves the requirement:

```bash
kubectl get nodes -o wide
kubectl get pods -A -o wide
kubectl cluster-info
kubeadm token create --print-join-command
```

## Documentation drill

Without using the solution file, find the relevant upstream documentation for **creating a cluster with kubeadm and installing a Pod network add-on**. Locate the exact field/command you would need if the task wording changed. Time the lookup; target **under 2 minutes** by Week 4.

## Failure injection / stretch

1. Run `kubeadm config view` and locate cluster networking settings.
2. Explain why CoreDNS commonly remains Pending before CNI installation.

## Cleanup / reset

1. Delete the namespace/resources created for this lab unless the next lab reuses them.
2. Return any node labels/taints/configuration changed only for this exercise to the baseline state.
3. Run `kubectl get nodes` and confirm the cluster is healthy.

## Debrief

Answer these in your error log or notes:

1. What did `kubeadm init` create versus what the CNI created?
2. Where does the join discovery token/hash fit?
3. What is your shortest convincing healthy-cluster proof?

## Solution

Do not open it until you have either completed the lab or spent the full timebox using official documentation: [`../../solutions/lab-17-build-a-multi-node-cluster-with-kubeadm.md`](../../solutions/lab-17-build-a-multi-node-cluster-with-kubeadm.md).
