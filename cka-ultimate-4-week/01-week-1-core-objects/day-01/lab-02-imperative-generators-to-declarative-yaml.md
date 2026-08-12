# Lab 02 — Imperative Generators to Declarative YAML

**Day:** 1  
**Primary domain:** Workloads & Scheduling  
**Timebox:** 35–50 min  
**Environment:** Healthy multi-node kubeadm cluster  
**Mode:** Hands-on

## Objective

- Generate valid resource YAML quickly with client-side dry run.
- Edit only the fields the task requires.
- Use `kubectl explain` to confirm field placement.

## Scenario

You need a Deployment manifest quickly, but typing API boilerplate by hand wastes time and invites indentation errors.

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

1. Generate `/tmp/web.yaml` for Deployment `web` with image `nginx:1.27` and 3 replicas using `--dry-run=client -o yaml`.
2. Before applying it, add container request `cpu: 25m` and limit `memory: 64Mi`.
3. Use `kubectl explain` to locate the exact resources field path rather than guessing.
4. Apply the file in `cka-lab`, wait for rollout, then save the live object YAML to `/tmp/web-live.yaml`.
5. Compare generated versus live YAML and identify at least three server-added fields.

## Success criteria

- Deployment has 3 Available replicas.
- Requests/limits appear on the Pod template.
- You can explain why generated client YAML is cleaner than live YAML for authoring.

## Verification

Run these (or an equivalent proof) and explain why each result proves the requirement:

```bash
kubectl rollout status deploy/web -n cka-lab --timeout=90s
kubectl get deploy web -n cka-lab -o jsonpath='{.status.availableReplicas}{"\n"}'
kubectl get pod -n cka-lab -l app=web -o jsonpath='{.items[0].spec.containers[0].resources}{"\n"}'
```

## Documentation drill

Without using the solution file, find the relevant upstream documentation for **`kubectl create deployment`, dry-run output, and `kubectl explain`**. Locate the exact field/command you would need if the task wording changed. Time the lookup; target **under 2 minutes** by Week 4.

## Failure injection / stretch

1. Regenerate the Deployment from scratch into a new file in under 60 seconds.
2. Use `kubectl diff -f /tmp/web.yaml` after changing replicas to 4, then explain what diff predicts before applying.

## Cleanup / reset

1. Delete the namespace/resources created for this lab unless the next lab reuses them.
2. Return any node labels/taints/configuration changed only for this exercise to the baseline state.
3. Run `kubectl get nodes` and confirm the cluster is healthy.

## Debrief

Answer these in your error log or notes:

1. When is imperative creation faster than YAML?
2. What is the difference between `--dry-run=client` and actually creating the object?
3. Why is `kubectl explain` valuable under exam conditions?

## Solution

Do not open it until you have either completed the lab or spent the full timebox using official documentation: [`../../solutions/lab-02-imperative-generators-to-declarative-yaml.md`](../../solutions/lab-02-imperative-generators-to-declarative-yaml.md).
