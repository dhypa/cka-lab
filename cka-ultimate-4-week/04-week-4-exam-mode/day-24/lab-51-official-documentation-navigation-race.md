# Lab 51 — Official Documentation Navigation Race

**Day:** 24  
**Primary domain:** Exam execution  
**Timebox:** 45–60 min  
**Environment:** Browser + terminal; follow current Linux Foundation allowed-resource policy  
**Mode:** Documentation race

## Objective

- Find exact syntax in allowed docs rapidly.
- Use page structure/search rather than broad web search habits.
- Build a personal retrieval map without prohibited external dependencies.

## Scenario

The exam permits a constrained set of web resources. Your ability to find a field/example inside official docs can be worth more than memorising it.

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

1. Open only the currently allowed documentation sites listed in Linux Foundation guidance. Set 2-minute timer per prompt.
2. Find, without using your course references: NetworkPolicy namespaceSelector+podSelector example; kubeadm upgrade worker command; etcd snapshot/restore example; RBAC ServiceAccount binding; PV reclaim policy; HPA CPU example; Kustomize patch example; Helm rollback command; Gateway API HTTPRoute backendRefs; DNS Service FQDN form.
3. For each, record: start time, page title, Ctrl+F/search term that worked, exact field/command name—not long copied text.
4. Repeat the five slowest immediately.
5. Create `/tmp/docs-map.txt` containing one-line navigation cues, not pasted tutorials.

## Success criteria

- 10 prompts completed.
- Second-pass lookup for slow topics improves.
- Notes contain navigation cues and exact API names, not copied answer banks.

## Verification

Run these (or an equivalent proof) and explain why each result proves the requirement:

```bash
cat /tmp/docs-map.txt
```

## Documentation drill

Without using the solution file, find the relevant upstream documentation for **Linux Foundation allowed-resources guidance plus official Kubernetes/Helm/Gateway documentation navigation**. Locate the exact field/command you would need if the task wording changed. Time the lookup; target **under 2 minutes** by Week 4.

## Failure injection / stretch

1. Do the race in the same browser/remote-desktop style you will use for mocks/simulator.
2. Have a friend/randomizer name ten blueprint terms and locate each page without Google/Bing.

## Cleanup / reset

1. Delete the namespace/resources created for this lab unless the next lab reuses them.
2. Return any node labels/taints/configuration changed only for this exercise to the baseline state.
3. Run `kubectl get nodes` and confirm the cluster is healthy.

## Debrief

Answer these in your error log or notes:

1. Which three pages took longest to locate?
2. What within-page terms were surprisingly effective?
3. Which syntax is worth memorising because lookup remains slow?

## Solution

Do not open it until you have either completed the lab or spent the full timebox using official documentation: [`../../solutions/lab-51-official-documentation-navigation-race.md`](../../solutions/lab-51-official-documentation-navigation-race.md).
