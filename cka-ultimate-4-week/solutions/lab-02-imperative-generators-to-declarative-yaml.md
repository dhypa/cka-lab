# Solution — Lab 02: Imperative Generators to Declarative YAML

This is a **reference path**, not the only valid solution. On CKA, satisfy the requested end state and verify it.

## Intended approach

1. Generate YAML then make a minimal edit under the container.
2. Apply and wait for rollout.
3. Inspect resource requirements from a created Pod.

## Canonical commands / evidence

```bash
kubectl create deployment web --image=nginx:1.27 --replicas=3 -n cka-lab --dry-run=client -o yaml > /tmp/web.yaml
kubectl explain deployment.spec.template.spec.containers.resources
kubectl apply -f /tmp/web.yaml
kubectl rollout status deploy/web -n cka-lab
```

## Expected evidence

- 3 ready replicas.
- Container resources reflect requested CPU and memory limit.

## Common traps

- Editing the Deployment-level `resources` instead of the container field.
- Using server output as a hand-maintained manifest and drowning in managed/defaulted fields.

## Explain it back

State the control-loop/API reason the solution works, and name the first two observations you would use if it did not.
