# Solution — Lab 01: Host, Context and Namespace Safety

This is a **reference path**, not the only valid solution. On CKA, satisfy the requested end state and verify it.

## Intended approach

1. Inspect identity first.
2. Create namespace and set the current context namespace.
3. Generate Pod imperatively.
4. Use explicit namespace verification and restore context.

## Canonical commands / evidence

```bash
kubectl create ns cka-lab
kubectl config set-context --current --namespace=cka-lab
kubectl run safety-pod --image=nginx:1.27 --restart=Never
hostname; kubectl config current-context; kubectl config view --minify
```

## Expected evidence

- Pod is present only in `cka-lab`.
- Minified kubeconfig shows the expected namespace.

## Common traps

- Assuming `kubectl config current-context` also tells you the namespace.
- Forgetting a namespace set on the current context persists into later tasks.

## Explain it back

State the control-loop/API reason the solution works, and name the first two observations you would use if it did not.
