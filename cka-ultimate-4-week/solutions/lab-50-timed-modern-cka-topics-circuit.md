# Solution — Lab 50: Timed Modern CKA Topics Circuit

This is a **reference path**, not the only valid solution. On CKA, satisfy the requested end state and verify it.

## Intended approach

1. Use local assets to avoid package-search time.
2. Timebox optional prerequisites.
3. Verify controller-dependent status explicitly.

## Canonical commands / evidence

```bash
helm history modern -n cka-helm
kubectl kustomize assets/kustomize/overlays/prod >/tmp/prod.yaml
kubectl get crd
kubectl describe hpa -A 2>/dev/null || true
```

## Expected evidence

- Modern topics no longer feel unfamiliar.
- Prerequisite absence is diagnosed correctly.

## Common traps

- Burning 20 minutes installing Gateway/metrics controller during a timed circuit.
- Treating Helm and Kustomize as conceptual-only topics.

## Explain it back

State the control-loop/API reason the solution works, and name the first two observations you would use if it did not.
