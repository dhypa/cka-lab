# Exam Strategy

## First 60 seconds

For every task, before changing anything:

```bash
hostname
kubectl config current-context
```

Read the requested host, cluster/context, namespace, resource names, output paths, and preservation constraints. If a task tells you to SSH to a host, do that first; leave it cleanly when finished.

## Three-pass approach

**Pass 1 — harvest**: solve tasks you can complete confidently in a few minutes. Mark hard/ambiguous tasks and move on.  
**Pass 2 — deliberate**: return to medium tasks, use docs and structured troubleshooting.  
**Pass 3 — verify**: revisit high-value/destructive tasks and run explicit checks.

Do not let one broken control plane consume half the exam before you have harvested easier points.

## Verification mindset

Useful proofs include:

```bash
kubectl get ... -o wide
kubectl describe ...
kubectl rollout status deployment/NAME
kubectl auth can-i ... --as=...
kubectl get endpointslice -l kubernetes.io/service-name=NAME
kubectl exec ... -- wget/curl/nslookup ...
kubectl wait --for=condition=Ready pod/... --timeout=...
sudo systemctl is-active kubelet
sudo journalctl -u kubelet --since '10 min ago'
```

The exact command depends on the task. The point is to leave evidence, not hope.

## Editing

Prefer generation + small edits over typing boilerplate:

```bash
kubectl create deployment web --image=nginx --dry-run=client -o yaml > /tmp/web.yaml
kubectl create service clusterip web --tcp=80:8080 --dry-run=client -o yaml
kubectl create role ... --dry-run=client -o yaml
```

Use `kubectl explain` and allowed docs to confirm unfamiliar fields.

## Troubleshooting ladder

1. Confirm host/context/namespace.
2. Inspect desired object and status.
3. Inspect events.
4. Inspect logs/current and previous containers.
5. Check selectors/endpoints/DNS/policies for traffic failures.
6. Check node conditions/resources/services for node failures.
7. Check static Pod manifests/component logs for control-plane failures.
8. Repair the smallest verified cause.
9. Prove the requested end state.

See `reference/troubleshooting-ladder.md`.
