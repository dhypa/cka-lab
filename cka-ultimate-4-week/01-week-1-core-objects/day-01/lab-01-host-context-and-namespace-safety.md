# Lab 01 — Host, Context and Namespace Safety

**Day:** 1  
**Primary domain:** Exam execution / Troubleshooting  
**Timebox:** 35–50 min  
**Environment:** Healthy multi-node kubeadm cluster  
**Mode:** Hands-on

## Objective

- Make host and kubeconfig checks automatic before changes.
- Create and switch namespaces without accidentally modifying another scope.
- Recover from a deliberately wrong current namespace.

## Scenario

You inherit a shell with multiple contexts and a task that explicitly names a namespace. A correct manifest applied to the wrong cluster or namespace earns nothing.

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

1. Create namespace `cka-lab` and set the current context namespace to it.
2. Create Pod `safety-pod` using `nginx:1.27` without writing YAML from scratch.
3. Prove which host, context, cluster and namespace your shell is targeting.
4. Temporarily set the current namespace to `default`, demonstrate that an unqualified lookup misses `safety-pod`, then restore `cka-lab`.
5. Write a one-line pre-task command sequence you will run in every later lab.

## Success criteria

- `safety-pod` is Running in `cka-lab` and absent from `default`.
- You can name the current host/context/namespace without guessing.
- Your shell finishes targeting `cka-lab`.

## Verification

Run these (or an equivalent proof) and explain why each result proves the requirement:

```bash
kubectl get pod safety-pod -n cka-lab
kubectl get pod safety-pod -n default 2>/dev/null || true
kubectl config view --minify -o jsonpath='{.contexts[0].context.namespace}{"\n"}'
```

## Documentation drill

Without using the solution file, find the relevant upstream documentation for **kubeconfig contexts, namespaces, and `kubectl config set-context --current`**. Locate the exact field/command you would need if the task wording changed. Time the lookup; target **under 2 minutes** by Week 4.

## Failure injection / stretch

1. Create a second context that points at the same cluster but defaults to `default`; switch between it and your normal context without deleting either.
2. Run a namespaced command with `-n cka-lab` while your current namespace is intentionally wrong and explain why explicit namespace flags are safer for high-risk tasks.

## Cleanup / reset

1. Delete the namespace/resources created for this lab unless the next lab reuses them.
2. Return any node labels/taints/configuration changed only for this exercise to the baseline state.
3. Run `kubectl get nodes` and confirm the cluster is healthy.

## Debrief

Answer these in your error log or notes:

1. Why can the same resource name exist in two namespaces?
2. Which resources are cluster-scoped and therefore ignore namespace?
3. What two checks prevent most scope mistakes?

## Solution

Do not open it until you have either completed the lab or spent the full timebox using official documentation: [`../../solutions/lab-01-host-context-and-namespace-safety.md`](../../solutions/lab-01-host-context-and-namespace-safety.md).
