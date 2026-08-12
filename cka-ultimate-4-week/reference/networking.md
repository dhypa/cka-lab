# Networking Reference

## Trace the path

For `client -> api.default.svc -> backend`:

1. Can client Pod resolve the name?
2. Does Service exist with correct `port`/`targetPort`?
3. Does Service selector match ready Pods?
4. Does EndpointSlice contain the expected Pod IPs/ports?
5. Can client reach a Pod IP directly (if useful for isolation)?
6. Does NetworkPolicy select client or server and permit the traffic?
7. For Ingress/Gateway, does a controller exist and report useful status?

## Service semantics

`port` is the Service port. `targetPort` is the backend port/name. `nodePort` is the node-exposed port for NodePort-type Services. A syntactically valid Service can be functionally useless if its selector matches no ready Pods.

## NetworkPolicy

Policies are additive. Once an ingress policy selects a Pod, incoming connections not allowed by any applicable ingress rule are denied (assuming the CNI enforces NetworkPolicy). Namespace and Pod selectors are easy to combine incorrectly—inspect labels explicitly.

## Gateway API mental model

`GatewayClass` describes a controller implementation/class. `Gateway` requests traffic-handling infrastructure/listeners. Route resources such as `HTTPRoute` bind to a Gateway and describe matching/forwarding. Status conditions are first-class evidence; a valid resource without an installed controller may remain unprogrammed/unaccepted.
