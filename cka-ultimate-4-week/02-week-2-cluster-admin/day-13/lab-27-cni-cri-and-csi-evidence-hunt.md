# Lab 27 — CNI, CRI and CSI Evidence Hunt

**Day:** 13  
**Primary domain:** Cluster Architecture / Troubleshooting  
**Timebox:** 35–50 min  
**Environment:** Healthy multi-node kubeadm cluster  
**Mode:** Hands-on

## Objective

- Assign CNI, CRI and CSI responsibilities correctly.
- Find concrete evidence of each interface in a live cluster.
- Use interface boundaries to narrow failures.

## Scenario

“Kubernetes networking/storage/runtime is broken” is too vague. You need to know which subsystem/controller/plugin to inspect next.

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

1. Identify your CRI runtime on each node from kubelet configuration/process/runtime endpoint and `crictl info` where available.
2. Identify the installed CNI from Pods/DaemonSets/config under `/etc/cni/net.d` and node network evidence.
3. List CSI drivers with `kubectl get csidrivers`; if none are installed, explain what that implies for dynamic storage classes in your cluster.
4. For one running Pod, find its node, container runtime ID and Pod IP; map each to the relevant subsystem.
5. Create a table `/tmp/interfaces.txt`: symptom → likely interface → first three evidence sources for “Pod sandbox network failed”, “container cannot start”, and “PVC provisioning failed”.

## Success criteria

- You can name the actual runtime/CNI/CSI present rather than generic products.
- Your symptom table routes investigation to the right subsystem.
- You understand the interfaces are contracts; implementations are replaceable.

## Verification

Run these (or an equivalent proof) and explain why each result proves the requirement:

```bash
kubectl get nodes -o wide
kubectl get pods -n kube-system -o wide
kubectl get csidrivers
ssh worker01 "sudo ls -l /etc/cni/net.d 2>/dev/null || true; sudo crictl info 2>/dev/null | head -30 || true"
cat /tmp/interfaces.txt
```

## Documentation drill

Without using the solution file, find the relevant upstream documentation for **container runtimes/CRI, network plugins/CNI, storage/CSI concepts and node debugging**. Locate the exact field/command you would need if the task wording changed. Time the lookup; target **under 2 minutes** by Week 4.

## Failure injection / stretch

1. Stop containerd on worker02 for at most two minutes after taking a snapshot; observe kubelet/node symptoms, then restore it. Compare with a CNI misconfiguration symptom from docs/events.
2. Inspect any StorageClass provisioner string and correlate it to installed CSI/controller Pods.

## Cleanup / reset

1. Delete the namespace/resources created for this lab unless the next lab reuses them.
2. Return any node labels/taints/configuration changed only for this exercise to the baseline state.
3. Run `kubectl get nodes` and confirm the cluster is healthy.

## Debrief

Answer these in your error log or notes:

1. Who creates a container: kubelet directly or via which interface/runtime?
2. What does the CNI handle in Pod lifecycle?
3. What evidence would make you investigate CSI before kubelet?

## Solution

Do not open it until you have either completed the lab or spent the full timebox using official documentation: [`../../solutions/lab-27-cni-cri-and-csi-evidence-hunt.md`](../../solutions/lab-27-cni-cri-and-csi-evidence-hunt.md).
