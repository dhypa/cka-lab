# Solution — Lab 28: Helm Install, Upgrade and Rollback

This is a **reference path**, not the only valid solution. On CKA, satisfy the requested end state and verify it.

## Intended approach

1. Lint/render local chart.
2. Install and inspect release.
3. Upgrade values; verify Kubernetes.
4. Create failing revision then rollback.

## Canonical commands / evidence

```bash
helm lint assets/charts/cka-web
helm template demo assets/charts/cka-web
helm install demo assets/charts/cka-web -n cka-helm --create-namespace
helm upgrade demo assets/charts/cka-web -n cka-helm --set replicaCount=4
helm history demo -n cka-helm
helm rollback demo <WORKING_REVISION> -n cka-helm
```

## Expected evidence

- Helm history increments per upgrade/rollback.
- Kubernetes rollout health must be checked separately from command exit/release existence.

## Common traps

- Installing unfamiliar chart without rendering/reading values.
- Assuming a Helm upgrade means application Pods became healthy.

## Explain it back

State the control-loop/API reason the solution works, and name the first two observations you would use if it did not.
