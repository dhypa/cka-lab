# Solution — Lab 19: Kubeconfig, Contexts and Client Identity

This is a **reference path**, not the only valid solution. On CKA, satisfy the requested end state and verify it.

## Intended approach

1. Inspect/backup config.
2. Create new contexts reusing existing named cluster/user.
3. Switch and verify namespace behaviour.

## Canonical commands / evidence

```bash
cp ~/.kube/config /tmp/kubeconfig.backup
kubectl config get-contexts
kubectl config set-context cka-default --cluster=$(kubectl config view --minify -o jsonpath='{.contexts[0].context.cluster}') --user=$(kubectl config view --minify -o jsonpath='{.contexts[0].context.user}') --namespace=default
kubectl config use-context cka-default
```

## Expected evidence

- Context table clearly shows different namespace defaults.
- Switching context does not change server-side permissions by itself.

## Common traps

- Confusing context namespace with authorization.
- Overwriting `~/.kube/config` while experimenting with merges.

## Explain it back

State the control-loop/API reason the solution works, and name the first two observations you would use if it did not.
