# Solution — Lab 52: Mock Exam Preflight and Scoring Discipline

This is a **reference path**, not the only valid solution. On CKA, satisfy the requested end state and verify it.

## Intended approach

1. Reset/health check.
2. Run Mock 1 under exact timer.
3. Freeze at deadline.
4. Score from evidence and classify misses.

## Canonical commands / evidence

```bash
kubectl get nodes
kubectl get pods -A
```

## Expected evidence

- No post-deadline fixes are included in score.
- Scorecard and error log are complete.

## Common traps

- Looking at solutions during timer.
- Giving yourself points for an almost-correct object that fails required verification.
- Continuing after 120 minutes and treating final state as timed score.

## Explain it back

State the control-loop/API reason the solution works, and name the first two observations you would use if it did not.
