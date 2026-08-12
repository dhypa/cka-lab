# Gateway API Reference

## Resource chain

`GatewayClass -> Gateway -> HTTPRoute -> Service`

Check which APIs/classes are installed:

```bash
kubectl api-resources | grep -E 'Gateway|HTTPRoute|gateway|httproute'
kubectl get gatewayclass
kubectl get gateway -A
kubectl get httproute -A
```

## Status-first debugging

```bash
kubectl describe gateway GW -n NS
kubectl describe httproute ROUTE -n NS
```

Look at conditions such as acceptance/programming and parent/backend references. Resource creation only proves API validation; a live route additionally depends on an installed compatible controller, class, listeners, permissions and reachable backend.

## Cross-namespace caution

Cross-namespace references can require explicit permission via Gateway API mechanisms such as `ReferenceGrant`. Do not assume a backend/reference across namespace boundaries is permitted just because the name is correct. Use current Gateway API docs for exact fields/version.
