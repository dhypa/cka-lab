# Solution — Lab 36: EndpointSlices and Selector-less Services

This is a **reference path**, not the only valid solution. On CKA, satisfy the requested end state and verify it.

## Intended approach

1. Create selector-less Service.
2. Add correctly labelled EndpointSlice.
3. Test and then induce stale endpoint by recreating backend.

## Canonical commands / evidence

```bash
kubectl get endpointslice -n cka-net-manual -l kubernetes.io/service-name=manual-service
kubectl run check -n cka-net-manual --rm -i --restart=Never --image=busybox:1.36 -- wget -qO- http://manual-service
```

## Expected evidence

- Manual EndpointSlice is the source of backend addresses.
- Service selector is absent.

## Common traps

- Adding selector later and accidentally creating conflicting controller-managed endpoints.
- Forgetting the required Service-name label on EndpointSlice.

## Explain it back

State the control-loop/API reason the solution works, and name the first two observations you would use if it did not.
