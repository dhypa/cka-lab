# Solution — Lab 15: Week 1 Capstone: Ship a Stateful Web Tier

This is a **reference path**, not the only valid solution. On CKA, satisfy the requested end state and verify it.

## Intended approach

1. Build requirements in dependency order: namespace/config/storage/scheduling/workload/service/client.
2. Verify each layer before introducing faults.
3. For repair, scope → workload → events → Service/endpoints → DNS/connectivity.
4. Generate the evidence file with `kubectl`/JSONPath rather than manually typing observed values.

## Canonical commands / evidence

```bash
kubectl get pods -n cka-capstone -o wide
kubectl get endpointslice -n cka-capstone -l kubernetes.io/service-name=web
kubectl get pvc -n cka-capstone
kubectl run verify-week1 -n cka-capstone --rm -i --restart=Never --image=busybox:1.36 -- wget -qO- http://web:8080
```

## Expected evidence

- All dependencies healthy and linked.
- Fault diagnosis uses observed evidence, not restart/delete guesses.

## Common traps

- Building everything then verifying only at the end.
- Creating three replicas while only one labelled node lacks enough resources and not reading Pending events.
- Writing report values by hand instead of from the live cluster.

## Explain it back

State the control-loop/API reason the solution works, and name the first two observations you would use if it did not.
