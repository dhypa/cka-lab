# Solution — Lab 06: Requests, Limits and Self-Healing Probes

This is a **reference path**, not the only valid solution. On CKA, satisfy the requested end state and verify it.

## Intended approach

1. Generate Deployment, edit resource/probe fields.
2. Expose and inspect EndpointSlice.
3. Repair readiness first; add sane liveness separately.

## Canonical commands / evidence

```bash
kubectl create deployment probe-web -n cka-lab --image=nginx:1.27 --replicas=2 --dry-run=client -o yaml > /tmp/probe-web.yaml
kubectl apply -f /tmp/probe-web.yaml
kubectl expose deploy probe-web -n cka-lab --port=80 --target-port=80
kubectl get endpointslice -n cka-lab -l kubernetes.io/service-name=probe-web
```

## Expected evidence

- Bad readiness removes Pods from ready Service endpoints without necessarily restarting them.
- Bad liveness triggers container restarts.

## Common traps

- Using liveness as a substitute for readiness.
- Forgetting that scheduler resource decisions are primarily based on requests, not current usage.

## Explain it back

State the control-loop/API reason the solution works, and name the first two observations you would use if it did not.
