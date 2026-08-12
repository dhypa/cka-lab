# Solution — Lab 31: Pod-to-Pod and Service Network Path

This is a **reference path**, not the only valid solution. On CKA, satisfy the requested end state and verify it.

## Intended approach

1. Create backend/service/client.
2. Record endpoints and test direct Pod path first.
3. Test Service IP/name separately.
4. Observe endpoint convergence during backend replacement.

## Canonical commands / evidence

```bash
kubectl get pods -n cka-net -o wide
kubectl get endpointslice -n cka-net -l kubernetes.io/service-name=echo
kubectl exec -n cka-net net-client -- wget -qO- http://echo
```

## Expected evidence

- Connectivity matrix separates CNI Pod routing from Service forwarding/name resolution.
- Backend replacement does not require Service recreation.

## Common traps

- Jumping immediately to DNS because a Service name was used.
- Testing only from the host instead of from a cluster Pod.

## Explain it back

State the control-loop/API reason the solution works, and name the first two observations you would use if it did not.
