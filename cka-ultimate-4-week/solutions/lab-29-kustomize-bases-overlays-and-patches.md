# Solution — Lab 29: Kustomize Bases, Overlays and Patches

This is a **reference path**, not the only valid solution. On CKA, satisfy the requested end state and verify it.

## Intended approach

1. Render both overlays.
2. Apply only after render validation.
3. Inspect transformed live resources.
4. Make one overlay-only image change and rollout.

## Canonical commands / evidence

```bash
kubectl apply -k assets/kustomize/overlays/dev
kubectl apply -k assets/kustomize/overlays/prod
kubectl diff -k assets/kustomize/overlays/prod || true
```

## Expected evidence

- Dev/prod differ only where overlay intends.
- Base remains unchanged.

## Common traps

- Editing the base to solve one environment-specific requirement.
- Applying an overlay without rendering when a patch fails to match.

## Explain it back

State the control-loop/API reason the solution works, and name the first two observations you would use if it did not.
