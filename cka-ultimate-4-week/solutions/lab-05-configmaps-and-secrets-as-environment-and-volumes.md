# Solution — Lab 05: ConfigMaps and Secrets as Environment and Volumes

This is a **reference path**, not the only valid solution. On CKA, satisfy the requested end state and verify it.

## Intended approach

1. Generate ConfigMap/Secret with `kubectl create ... --dry-run=client -o yaml` if useful.
2. Create a Pod spec with `env.valueFrom`, volume and volumeMounts.
3. Patch/reapply the ConfigMap and wait for mounted projection refresh.

## Canonical commands / evidence

```bash
kubectl create ns cka-config
kubectl create configmap app-config -n cka-config --from-literal=MODE=production --from-file=message.txt
kubectl create secret generic app-secret -n cka-config --from-literal=token=swordfish
kubectl exec -n cka-config config-reader -- env | grep -E '^(MODE|TOKEN)='
```

## Expected evidence

- Both env values are supplied from the referenced objects.
- Mounted ConfigMap file reflects the object update eventually.

## Common traps

- Assuming Kubernetes Secrets are encrypted merely because values appear base64-encoded.
- Expecting an environment variable sourced from a ConfigMap to update inside an already-running process.

## Explain it back

State the control-loop/API reason the solution works, and name the first two observations you would use if it did not.
