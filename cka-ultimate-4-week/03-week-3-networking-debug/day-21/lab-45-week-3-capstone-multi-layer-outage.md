# Lab 45 — Week 3 Capstone: Multi-Layer Outage

**Day:** 21  
**Primary domain:** Troubleshooting / Networking / Workloads  
**Timebox:** 120 min  
**Environment:** Healthy multi-node kubeadm cluster  
**Mode:** Capstone

## Objective

- Recover a layered outage without being told fault locations.
- Maintain a hypothesis/evidence/change journal.
- Prioritise root causes and verify end-to-end recovery.

## Scenario

A business-critical internal API is down after simultaneous application and infrastructure changes. This is a troubleshooting exam in miniature.

## Prerequisites

- A healthy practice cluster and working `kubectl`.

## Safety / starting-state check

> Potential shared-cluster faults. Snapshot before system-component or node-service injection and keep a separate baseline manifest copy.

Run and read the output before proceeding:

```bash
hostname
kubectl config current-context
kubectl get nodes -o wide
```

## Lab setup

1. Create any named namespace/resources only when instructed. Do not reuse leftovers from a previous attempt.

## Tasks

1. Build namespace `cka-capstone` with Deployment `api` (3 replicas), Service, client, and a default-deny + narrow allow policy. Prove healthy baseline and save manifests.
2. Choose or have another person/script inject **four** independent faults from this pool: bad Deployment image; invalid readiness path; Service selector mismatch; targetPort mismatch; allowed-client label mismatch; impossible node affinity; stopped kubelet on worker02; CoreDNS scale reduction (only on disposable cluster). Do not leave yourself a list of chosen faults.
3. Set a 60-minute timer. Start an incident log `/tmp/week3-incident.txt` with timestamped evidence/hypotheses. Do not make a change until you can state what evidence supports it.
4. Recover end-to-end DNS + HTTP for the intended client, 3 Ready replicas, correct endpoint population and all nodes Ready. Preserve intended NetworkPolicy restriction.
5. Write final root-cause list and verification commands. Restore every shared cluster component changed.

## Success criteria

- All intended clients succeed and denied clients remain denied.
- 3 Deployment replicas Ready, Service endpoints correct, nodes Ready, DNS healthy.
- Incident log contains at least one disproved hypothesis and four evidenced root causes.
- Shared system components are returned to baseline.

## Verification

Run these (or an equivalent proof) and explain why each result proves the requirement:

```bash
kubectl get nodes
kubectl get deploy,po,svc,endpointslice,networkpolicy -n cka-capstone -o wide
kubectl -n kube-system get pods -l k8s-app=kube-dns
cat /tmp/week3-incident.txt
```

## Documentation drill

Without using the solution file, find the relevant upstream documentation for **Use only the official topic page corresponding to the evidence you uncover; practise targeted retrieval rather than broad browsing**. Locate the exact field/command you would need if the task wording changed. Time the lookup; target **under 2 minutes** by Week 4.

## Failure injection / stretch

1. Reset and repeat with three random faults and a 30-minute cap.
2. Have a peer inject faults remotely while you remain in a separate shell so you cannot infer changes from command history.

## Cleanup / reset

1. Delete the namespace/resources created for this lab unless the next lab reuses them.
2. Return any node labels/taints/configuration changed only for this exercise to the baseline state.
3. Run `kubectl get nodes` and confirm the cluster is healthy.

## Debrief

Answer these in your error log or notes:

1. Which fault was hardest to isolate and why?
2. What evidence disproved a hypothesis?
3. Which step in your troubleshooting ladder needs changing before Week 4?

## Solution

Do not open it until you have either completed the lab or spent the full timebox using official documentation: [`../../solutions/lab-45-week-3-capstone-multi-layer-outage.md`](../../solutions/lab-45-week-3-capstone-multi-layer-outage.md).
