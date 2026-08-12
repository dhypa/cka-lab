# Lab 23 — Kubernetes Certificates and Expiry Inspection

**Day:** 11  
**Primary domain:** Cluster Architecture, Installation & Configuration  
**Timebox:** 35–50 min  
**Environment:** Healthy multi-node kubeadm cluster  
**Mode:** Hands-on

## Objective

- Inspect kubeadm-managed certificate expiration.
- Locate client/server certificate references.
- Understand which cert problems can break node/control-plane communication.

## Scenario

You are asked for a certificate-expiry health check before maintenance, not a blind rotation. Inventory first and understand which credentials belong to which components.

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

1. On controlplane run the kubeadm certificate expiration check and save output to `/tmp/cert-expiry.txt`.
2. List `/etc/kubernetes/pki` and classify at least: CA, API server certificate/key, API server-kubelet client cert, front-proxy CA, etcd certificates.
3. Use `openssl x509 -noout -subject -issuer -dates` on two certificates and compare with kubeadm output.
4. Inspect a kubeconfig and identify embedded client-certificate-data versus referenced files.
5. Research the current kubeadm certificate renewal procedure but do not rotate a healthy cluster purely for the exercise unless you have a snapshot and intentionally want the stretch.

## Success criteria

- Expiration report exists.
- You can locate API server and etcd certificate material on a default kubeadm control plane.
- You can explain why changing certs may require component restart/reload behaviour.

## Verification

Run these (or an equivalent proof) and explain why each result proves the requirement:

```bash
sudo kubeadm certs check-expiration
sudo openssl x509 -in /etc/kubernetes/pki/apiserver.crt -noout -subject -issuer -dates
sudo ls -l /etc/kubernetes/pki
```

## Documentation drill

Without using the solution file, find the relevant upstream documentation for **kubeadm certificate management**. Locate the exact field/command you would need if the task wording changed. Time the lookup; target **under 2 minutes** by Week 4.

## Failure injection / stretch

1. On a snapshot, renew one kubeadm-managed certificate using current docs and observe which static Pod needs recreation to pick it up. Restore if anything is unclear.
2. Inspect kubelet client certificate location/symlink on a worker and compare lifecycle ownership with control-plane certs.

## Cleanup / reset

1. Delete the namespace/resources created for this lab unless the next lab reuses them.
2. Return any node labels/taints/configuration changed only for this exercise to the baseline state.
3. Run `kubectl get nodes` and confirm the cluster is healthy.

## Debrief

Answer these in your error log or notes:

1. Which CA signs the API server certificate in a normal kubeadm cluster?
2. Why are etcd certificates separate?
3. What would an expired kubelet client credential look like operationally?

## Solution

Do not open it until you have either completed the lab or spent the full timebox using official documentation: [`../../solutions/lab-23-kubernetes-certificates-and-expiry-inspection.md`](../../solutions/lab-23-kubernetes-certificates-and-expiry-inspection.md).
