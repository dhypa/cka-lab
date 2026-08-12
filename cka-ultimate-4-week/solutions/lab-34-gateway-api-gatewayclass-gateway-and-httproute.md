# Solution — Lab 34: Gateway API: GatewayClass, Gateway and HTTPRoute

This is a **reference path**, not the only valid solution. On CKA, satisfy the requested end state and verify it.

## Intended approach

1. Inventory APIs/classes first.
2. Create Service backend.
3. Create Gateway then route.
4. Treat status conditions as evidence; perform live request only with controller.

## Canonical commands / evidence

```bash
kubectl api-resources | grep -E "gateway|httproute"
kubectl get gatewayclass
kubectl get gateway,httproute -n cka-gateway
```

## Expected evidence

- Objects are syntactically valid and linked.
- Live routing claim is made only if controller/class/address are present.

## Common traps

- Inventing a GatewayClass name and then assuming the route is live.
- Ignoring route/Gateway status conditions.

## Explain it back

State the control-loop/API reason the solution works, and name the first two observations you would use if it did not.
