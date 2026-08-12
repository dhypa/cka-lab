# Lab 05 — ConfigMaps and Secrets as Environment and Volumes

**Day:** 2  
**Primary domain:** Workloads & Scheduling  
**Timebox:** 35–50 min  
**Environment:** Healthy multi-node kubeadm cluster  
**Mode:** Hands-on

## Objective

- Create ConfigMaps/Secrets from literals and files.
- Consume configuration as both env vars and mounted files.
- Understand which updates become visible without Pod recreation.

## Scenario

A workload needs non-sensitive mode configuration and a sensitive token. Operations wants one setting injected as an environment variable and another delivered as a file.

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

1. Create namespace `cka-config`.
2. Create ConfigMap `app-config` with `MODE=production` and file key `message.txt` containing `hello-cka`.
3. Create Secret `app-secret` with literal `token=swordfish`.
4. Create Pod `config-reader` using `busybox:1.36`, sleeping for an hour. Inject `MODE` as an env var, mount the ConfigMap at `/config`, and expose the Secret token as env var `TOKEN`.
5. Exec into the Pod and prove all three values.
6. Update ConfigMap `message.txt` to `updated`; observe the projected volume after propagation and compare with the already-created environment variable behaviour.

## Success criteria

- Pod prints `production`, `hello-cka`/then `updated`, and the expected token when explicitly queried.
- Secret value is not written into the lab report/terminal history beyond this known practice value.
- You can explain update semantics for env vars versus projected ConfigMap volumes.

## Verification

Run these (or an equivalent proof) and explain why each result proves the requirement:

```bash
kubectl exec -n cka-config config-reader -- sh -c 'test "$MODE" = production && echo mode-ok'
kubectl exec -n cka-config config-reader -- cat /config/message.txt
kubectl get secret app-secret -n cka-config -o jsonpath='{.data.token}' | base64 -d; echo
```

## Documentation drill

Without using the solution file, find the relevant upstream documentation for **ConfigMaps, Secrets, environment variables and projected volumes**. Locate the exact field/command you would need if the task wording changed. Time the lookup; target **under 2 minutes** by Week 4.

## Failure injection / stretch

1. Make the mounted ConfigMap read-only explicitly and verify writes fail.
2. Replace direct Secret env reference with a Secret volume and compare the manifest structure.

## Cleanup / reset

1. Delete the namespace/resources created for this lab unless the next lab reuses them.
2. Return any node labels/taints/configuration changed only for this exercise to the baseline state.
3. Run `kubectl get nodes` and confirm the cluster is healthy.

## Debrief

Answer these in your error log or notes:

1. Why are ConfigMaps and Secrets separate API kinds?
2. What is base64 doing in a Secret manifest, and what is it not doing?
3. Which consumption style supports eventual projected updates without Pod restart?

## Solution

Do not open it until you have either completed the lab or spent the full timebox using official documentation: [`../../solutions/lab-05-configmaps-and-secrets-as-environment-and-volumes.md`](../../solutions/lab-05-configmaps-and-secrets-as-environment-and-volumes.md).
