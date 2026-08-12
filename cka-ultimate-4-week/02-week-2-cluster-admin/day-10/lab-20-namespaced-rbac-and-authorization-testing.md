# Lab 20 — Namespaced RBAC and Authorization Testing

**Day:** 10  
**Primary domain:** Cluster Architecture, Installation & Configuration  
**Timebox:** 35–50 min  
**Environment:** Healthy multi-node kubeadm cluster  
**Mode:** Hands-on

## Objective

- Create Role and RoleBinding using imperative generators.
- Reason about verbs/resources/resourceNames.
- Verify authorization with `kubectl auth can-i`.

## Scenario

A support identity should read Pods in one namespace but must not modify them or read another namespace.

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

1. Create namespace `cka-rbac` and a test Pod.
2. Create Role `pod-reader` permitting `get,list,watch` on Pods in `cka-rbac`.
3. Bind the Role to user `alice` using RoleBinding `alice-read-pods`.
4. Use `kubectl auth can-i` as alice to test get/list/delete in `cka-rbac` and get in `default`.
5. Modify the Role to permit reading Pod logs (`pods/log`) and prove the subresource check.
6. Export Role and RoleBinding YAML to `/tmp/rbac/`.

## Success criteria

- alice can get/list/watch Pods and get Pod logs in `cka-rbac`.
- alice cannot delete Pods through this grant.
- This RoleBinding does not grant equivalent access in default.

## Verification

Run these (or an equivalent proof) and explain why each result proves the requirement:

```bash
kubectl auth can-i get pods -n cka-rbac --as=alice
kubectl auth can-i delete pods -n cka-rbac --as=alice
kubectl auth can-i get pods -n default --as=alice
kubectl auth can-i get pods/log -n cka-rbac --as=alice
```

## Documentation drill

Without using the solution file, find the relevant upstream documentation for **RBAC Roles, RoleBindings, subresources, and `kubectl auth can-i`**. Locate the exact field/command you would need if the task wording changed. Time the lookup; target **under 2 minutes** by Week 4.

## Failure injection / stretch

1. Restrict `get` to a named ConfigMap using `resourceNames`; observe why `list` cannot be constrained the same way in the way beginners often expect.
2. Bind an existing ClusterRole with a RoleBinding and explain the namespace effect.

## Cleanup / reset

1. Delete the namespace/resources created for this lab unless the next lab reuses them.
2. Return any node labels/taints/configuration changed only for this exercise to the baseline state.
3. Run `kubectl get nodes` and confirm the cluster is healthy.

## Debrief

Answer these in your error log or notes:

1. What is the difference between Role and ClusterRole?
2. What subjects can RoleBinding target?
3. Why should you always include at least one negative `can-i` test?

## Solution

Do not open it until you have either completed the lab or spent the full timebox using official documentation: [`../../solutions/lab-20-namespaced-rbac-and-authorization-testing.md`](../../solutions/lab-20-namespaced-rbac-and-authorization-testing.md).
