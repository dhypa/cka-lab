# Solution — Lab 40: Resource Usage, Logs and Events Triage

This is a **reference path**, not the only valid solution. On CKA, satisfy the requested end state and verify it.

## Intended approach

1. Inject distinct failure classes.
2. Triage under timer without editing.
3. Write evidence-based hypotheses.
4. Then repair and verify.

## Canonical commands / evidence

```bash
kubectl get pods -n cka-debug
kubectl describe pod -n cka-debug <POD>
kubectl logs -n cka-debug <POD> --previous
```

## Expected evidence

- Each diagnosis references a concrete status/event/log fact.
- No “restart everything” shortcut.

## Common traps

- Looking at only latest log line.
- Missing `lastState.terminated.reason` or previous logs for restarted containers.

## Explain it back

State the control-loop/API reason the solution works, and name the first two observations you would use if it did not.
