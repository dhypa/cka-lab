# Lab 19 — Kubeconfig, Contexts and Client Identity

**Day:** 9  
**Primary domain:** Cluster Architecture / Exam execution  
**Timebox:** 35–50 min  
**Environment:** Healthy multi-node kubeadm cluster  
**Mode:** Hands-on

## Objective

- Read kubeconfig cluster/user/context structure.
- Create and switch contexts safely.
- Use a separate credential/config without clobbering admin config.

## Scenario

An administrator is given multiple cluster/user combinations. You must know what a context selects and avoid editing the only working kubeconfig destructively.

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

1. Back up `~/.kube/config`. Use `kubectl config get-contexts` and minified view to map current context → cluster/user/namespace.
2. Create context `cka-default` using the existing cluster/user but namespace `default`; create `cka-labctx` pointing to namespace `cka-lab`.
3. Switch between them and prove unqualified resource lookup changes namespace scope.
4. Inspect `/etc/kubernetes/admin.conf` on controlplane and identify embedded certificate-authority/client certificate data fields.
5. Use `KUBECONFIG=/etc/kubernetes/admin.conf` under appropriate permissions (or a safe copy) for one command, then return to your normal config.

## Success criteria

- Both contexts work without duplicating cluster credentials unnecessarily.
- You can identify current user/cluster/namespace from kubeconfig.
- Original kubeconfig remains backed up and functional.

## Verification

Run these (or an equivalent proof) and explain why each result proves the requirement:

```bash
kubectl config get-contexts
kubectl config view --minify
kubectl config current-context
```

## Documentation drill

Without using the solution file, find the relevant upstream documentation for **organizing cluster access using kubeconfig files and contexts**. Locate the exact field/command you would need if the task wording changed. Time the lookup; target **under 2 minutes** by Week 4.

## Failure injection / stretch

1. Merge a second safe kubeconfig copy using `KUBECONFIG=file1:file2 kubectl config view --flatten` into `/tmp/merged`. Do not overwrite your working file.
2. Set a namespace on a context and explain why that is client-side convenience, not an RBAC boundary.

## Cleanup / reset

1. Delete the namespace/resources created for this lab unless the next lab reuses them.
2. Return any node labels/taints/configuration changed only for this exercise to the baseline state.
3. Run `kubectl get nodes` and confirm the cluster is healthy.

## Debrief

Answer these in your error log or notes:

1. What are the three references inside a context?
2. Can namespace in kubeconfig prevent a user from accessing other namespaces if RBAC allows them?
3. How would you use a task-provided kubeconfig without losing your normal one?

## Solution

Do not open it until you have either completed the lab or spent the full timebox using official documentation: [`../../solutions/lab-19-kubeconfig-contexts-and-client-identity.md`](../../solutions/lab-19-kubeconfig-contexts-and-client-identity.md).
