# Solution — Lab 45: Week 3 Capstone: Multi-Layer Outage

This is a **reference path**, not the only valid solution. On CKA, satisfy the requested end state and verify it.

## Intended approach

1. Establish and save known-good baseline.
2. Inject/receive unknown independent faults.
3. Use scope → workload → events/logs → endpoints → DNS/policy → node/control-plane ladder.
4. Change one evidenced cause at a time.
5. Verify user path and infrastructure baseline.

## Canonical commands / evidence

```bash
kubectl get events -A --sort-by=.lastTimestamp | tail -40
kubectl get pods -A -o wide
kubectl get endpointslice -n cka-capstone
kubectl get networkpolicy -n cka-capstone -o yaml
```

## Expected evidence

- Recovery is end-to-end, not merely Pod Running.
- Incident notes distinguish symptom from root cause.

## Common traps

- Making several speculative changes simultaneously.
- Deleting policies/system components to get green output.
- Forgetting to restore injected node/DNS fault after app recovery.

## Explain it back

State the control-loop/API reason the solution works, and name the first two observations you would use if it did not.
