# Lab 22 — etcd Snapshot and Restore

**Day:** 11  
**Primary domain:** Cluster Architecture / Troubleshooting  
**Timebox:** 75–105 min  
**Environment:** kubeadm control plane with local stacked etcd and snapshot tooling  
**Mode:** Hands-on

## Objective

- Create and verify an etcd snapshot on a kubeadm control plane.
- Locate correct endpoints/certificates from the etcd manifest.
- Restore safely with a plan that accounts for static-Pod configuration.

## Scenario

The cluster state store needs a tested backup. A backup file that was never verified or cannot be restored is not a recovery plan.

## Prerequisites

- A healthy practice cluster and working `kubectl`.

## Safety / starting-state check

> Destructive restore exercise. Take a VM snapshot and confirm you are on `controlplane`. Use current upstream etcd/Kubernetes restore instructions because tooling (`etcdctl`/`etcdutl`) evolves.

Run and read the output before proceeding:

```bash
hostname
kubectl config current-context
kubectl get nodes -o wide
```

## Lab setup

1. Create any named namespace/resources only when instructed. Do not reuse leftovers from a previous attempt.

## Tasks

1. Take snapshot `30-pre-etcd` before the lab. On controlplane, inspect `/etc/kubernetes/manifests/etcd.yaml` for data dir, endpoint and TLS paths.
2. Using the etcd tooling available for your version, save a snapshot to `/var/backups/cka-etcd.db`; create the directory if needed.
3. Run the appropriate snapshot status/verification command and record size/revision/key count when available.
4. Create namespace `restore-marker` and ConfigMap `marker` after the snapshot.
5. Perform a **full restore only if your environment/docs/tooling are ready**: restore to a new data directory, update the static etcd manifest hostPath to that restored directory, allow kubelet to recreate etcd, and prove the post-snapshot marker disappears. Otherwise write the exact restore plan and perform it after taking another snapshot.
6. Return the cluster to a known healthy state and save recovery notes.

## Success criteria

- Snapshot file exists and passes status/verification.
- You can identify the TLS files required for local etcd access.
- After an actual restore, cluster state reflects snapshot time and API becomes healthy again.

## Verification

Run these (or an equivalent proof) and explain why each result proves the requirement:

```bash
sudo ls -lh /var/backups/cka-etcd.db
kubectl get nodes
kubectl get ns restore-marker 2>/dev/null || true
sudo grep -E -- "--data-dir|client-cert-auth|trusted-ca|cert-file|key-file" /etc/kubernetes/manifests/etcd.yaml
```

## Documentation drill

Without using the solution file, find the relevant upstream documentation for **backing up and restoring an etcd cluster**. Locate the exact field/command you would need if the task wording changed. Time the lookup; target **under 2 minutes** by Week 4.

## Failure injection / stretch

1. Copy the snapshot off-node to `cka-shell` and record checksum. Explain why same-disk-only backup is weak disaster recovery.
2. After restore, inspect static Pod/container restart evidence and explain why API connectivity may briefly disappear.

## Cleanup / reset

1. Delete the namespace/resources created for this lab unless the next lab reuses them.
2. Return any node labels/taints/configuration changed only for this exercise to the baseline state.
3. Run `kubectl get nodes` and confirm the cluster is healthy.

## Debrief

Answer these in your error log or notes:

1. What exactly is captured in an etcd snapshot?
2. Why is manifest inspection safer than memorising certificate paths?
3. What evidence proves a restore rather than merely an etcd restart?

## Solution

Do not open it until you have either completed the lab or spent the full timebox using official documentation: [`../../solutions/lab-22-etcd-snapshot-and-restore.md`](../../solutions/lab-22-etcd-snapshot-and-restore.md).
