# Solution — Lab 11: Services, Ports and EndpointSlices

This is a **reference path**, not the only valid solution. On CKA, satisfy the requested end state and verify it.

## Intended approach

1. Create Deployment and Service.
2. Use EndpointSlice to separate selector correctness from backend-port correctness.
3. Test from inside cluster and patch targetPort.

## Canonical commands / evidence

```bash
kubectl create deploy web80 -n cka-net --image=nginx:1.27 --replicas=2
kubectl expose deploy web80 -n cka-net --name=web80 --port=8080 --target-port=8081
kubectl get endpointslice -n cka-net -l kubernetes.io/service-name=web80
kubectl patch svc web80 -n cka-net -p '{"spec":{"ports":[{"port":8080,"targetPort":80}]}}'
```

## Expected evidence

- Endpoints exist with correct selector even while application traffic is sent to the wrong port.
- After patch, in-cluster HTTP returns nginx content.

## Common traps

- Treating an EndpointSlice with addresses as proof the target port serves traffic.
- Confusing the Service port clients use with container backend port.

## Explain it back

State the control-loop/API reason the solution works, and name the first two observations you would use if it did not.
