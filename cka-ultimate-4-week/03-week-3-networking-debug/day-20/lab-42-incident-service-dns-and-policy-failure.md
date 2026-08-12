# Lab 42 — Incident: Service, DNS and Policy Failure

**Day:** 20  
**Primary domain:** Troubleshooting / Services & Networking  
**Timebox:** 50–65 min  
**Environment:** Healthy multi-node kubeadm cluster  
**Mode:** Incident

## Objective

- Separate DNS, Service and NetworkPolicy failure modes.
- Use controlled comparisons to isolate policy.
- Repair narrow access without opening the namespace.

## Scenario

An API hostname resolves, but one client times out while another should be allowed. A previous engineer also changed the Service. You must identify every layer independently.

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

1. Reapply `assets/networkpolicy-seed.yaml` into a clean `cka-net` and verify baseline.
2. Create default-deny ingress and narrow allow for `access=allowed`. Confirm intended behaviour.
3. Now inject two faults without writing them down in your notes: change Service targetPort to 8081 and change allowed-client label to `access=trusted`. Wait one minute.
4. Set a 30-minute timer and diagnose from scratch. Explicitly test DNS resolution, Service/EndpointSlice, direct Pod IP, and policy/labels.
5. Restore HTTP for the intended `client-allowed` only; `client-denied` must remain blocked.

## Success criteria

- DNS lookup works throughout unless you deliberately alter DNS.
- Both independent Service-port and policy-label faults are found.
- Final allowed/denied behaviour matches requirement.

## Verification

Run these (or an equivalent proof) and explain why each result proves the requirement:

```bash
kubectl exec -n cka-net client-allowed -- nslookup api
kubectl get svc,endpointslice -n cka-net
kubectl get netpol -n cka-net -o yaml
kubectl exec -n cka-net client-allowed -- wget -T 3 -qO- http://api
kubectl exec -n cka-net client-denied -- wget -T 3 -qO- http://api || echo expected-deny
```

## Documentation drill

Without using the solution file, find the relevant upstream documentation for **Service debugging, DNS debugging and NetworkPolicy**. Locate the exact field/command you would need if the task wording changed. Time the lookup; target **under 2 minutes** by Week 4.

## Failure injection / stretch

1. Add an egress policy that accidentally blocks DNS; diagnose the new difference between NXDOMAIN/timeout and resolved-but-blocked application traffic.
2. Create an equivalent policy using namespaceSelector + podSelector and explain boolean structure.

## Cleanup / reset

1. Delete the namespace/resources created for this lab unless the next lab reuses them.
2. Return any node labels/taints/configuration changed only for this exercise to the baseline state.
3. Run `kubectl get nodes` and confirm the cluster is healthy.

## Debrief

Answer these in your error log or notes:

1. Which test best isolated Service port from policy?
2. What did DNS prove—and what did it not prove?
3. How did you preserve least privilege while repairing?

## Solution

Do not open it until you have either completed the lab or spent the full timebox using official documentation: [`../../solutions/lab-42-incident-service-dns-and-policy-failure.md`](../../solutions/lab-42-incident-service-dns-and-policy-failure.md).
