# Lab 21 — ServiceAccounts and Cluster-Scoped RBAC

**Day:** 10  
**Primary domain:** Cluster Architecture, Installation & Configuration  
**Timebox:** 35–50 min  
**Environment:** Healthy multi-node kubeadm cluster  
**Mode:** Hands-on

## Objective

- Create ServiceAccounts and bind permissions.
- Use ClusterRole/ClusterRoleBinding for cluster-scoped resources.
- Test authorization as a ServiceAccount principal.

## Scenario

A monitoring Pod needs to list Nodes cluster-wide and read Pods only in its own namespace. Design least-privilege grants rather than making it cluster-admin.

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

1. Create ServiceAccount `observer` in `cka-rbac`.
2. Create ClusterRole `node-reader` allowing `get,list,watch` on Nodes, and bind it to the ServiceAccount with ClusterRoleBinding.
3. Reuse/create a namespaced Pod-reader Role and RoleBinding for observer in `cka-rbac`.
4. Test with `--as=system:serviceaccount:cka-rbac:observer`: list nodes, get pods in cka-rbac, get pods in default, delete nodes.
5. Create a Pod using serviceAccountName `observer` and inspect its identity/token projection fields without printing the token.

## Success criteria

- Observer can read Nodes and cka-rbac Pods.
- Observer cannot delete Nodes and gets no Pod read permission in default from the namespaced Role.
- You can spell the ServiceAccount username form correctly.

## Verification

Run these (or an equivalent proof) and explain why each result proves the requirement:

```bash
kubectl auth can-i list nodes --as=system:serviceaccount:cka-rbac:observer
kubectl auth can-i get pods -n cka-rbac --as=system:serviceaccount:cka-rbac:observer
kubectl auth can-i get pods -n default --as=system:serviceaccount:cka-rbac:observer
kubectl auth can-i delete nodes --as=system:serviceaccount:cka-rbac:observer
```

## Documentation drill

Without using the solution file, find the relevant upstream documentation for **ServiceAccounts, ClusterRoles, ClusterRoleBindings and RBAC good practices**. Locate the exact field/command you would need if the task wording changed. Time the lookup; target **under 2 minutes** by Week 4.

## Failure injection / stretch

1. Bind the built-in `view` ClusterRole with a RoleBinding in `cka-rbac`; compare its breadth with your tiny custom Role. Remove it after inspection.
2. Set `automountServiceAccountToken: false` on a Pod and inspect mounted credentials.

## Cleanup / reset

1. Delete the namespace/resources created for this lab unless the next lab reuses them.
2. Return any node labels/taints/configuration changed only for this exercise to the baseline state.
3. Run `kubectl get nodes` and confirm the cluster is healthy.

## Debrief

Answer these in your error log or notes:

1. Why can a RoleBinding reference a ClusterRole?
2. What changes when the binding itself is ClusterRoleBinding?
3. How is a ServiceAccount represented to the authorizer?

## Solution

Do not open it until you have either completed the lab or spent the full timebox using official documentation: [`../../solutions/lab-21-serviceaccounts-and-cluster-scoped-rbac.md`](../../solutions/lab-21-serviceaccounts-and-cluster-scoped-rbac.md).
