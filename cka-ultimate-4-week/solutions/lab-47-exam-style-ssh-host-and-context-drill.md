# Solution — Lab 47: Exam-Style SSH Host and Context Drill

This is a **reference path**, not the only valid solution. On CKA, satisfy the requested end state and verify it.

## Intended approach

1. Build six terse tasks.
2. Use preflight on every task.
3. Exit designated host cleanly.
4. Audit and repeat until zero scope errors.

## Canonical commands / evidence

```bash
hostname; kubectl config current-context
ssh controlplane hostname
ssh worker01 systemctl is-active kubelet
```

## Expected evidence

- Task history proves correct host/context.
- No temporary cluster change remains.

## Common traps

- Nested SSH and forgetting where you are.
- Assuming a previous task’s namespace/context carries safely into the next.

## Explain it back

State the control-loop/API reason the solution works, and name the first two observations you would use if it did not.
