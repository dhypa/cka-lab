# Solution — Lab 37: CustomResourceDefinition and Schema Validation

This is a **reference path**, not the only valid solution. On CKA, satisfy the requested end state and verify it.

## Intended approach

1. Apply CRD and wait Established.
2. Create valid/invalid CRs.
3. Use discovery/explain to inspect API.

## Canonical commands / evidence

```bash
kubectl apply -f assets/widgets-crd.yaml
kubectl wait --for=condition=Established crd/widgets.training.cka.io --timeout=60s
kubectl explain widget.spec
kubectl get wdg -n cka-crd
```

## Expected evidence

- Schema minimum/type rules reject bad objects.
- API persistence alone does not reconcile external state.

## Common traps

- Calling a CRD an operator.
- Using non-structural/invalid schema and blaming kubectl.

## Explain it back

State the control-loop/API reason the solution works, and name the first two observations you would use if it did not.
