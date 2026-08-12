# Gateway API lab asset

Gateway API resources require Gateway API CRDs to exist. A useful live test also requires a compatible Gateway controller and an appropriate `GatewayClass`.

For course labs:

1. Check first: `kubectl api-resources | grep -E 'gateway|httproute'`.
2. If the API is absent, install Gateway API CRDs by following the **current official Gateway API documentation** rather than pinning this course to an old release URL.
3. If no controller/GatewayClass exists, still practise authoring resources and inspecting API validation/status, but do not claim traffic works.
4. If a controller exists, use its advertised `GatewayClass` and run the live routing verification sections.

Official docs: https://gateway-api.sigs.k8s.io/
