# Solution — Lab 20: Namespaced RBAC and Authorization Testing

This is a **reference path**, not the only valid solution. On CKA, satisfy the requested end state and verify it.

## Intended approach

1. Generate Role/RoleBinding with kubectl where possible.
2. Add `pods/log` explicitly.
3. Test positive and negative authorization before declaring success.

## Canonical commands / evidence

```bash
kubectl create role pod-reader -n cka-rbac --verb=get,list,watch --resource=pods
kubectl create rolebinding alice-read-pods -n cka-rbac --role=pod-reader --user=alice
kubectl auth can-i get pods -n cka-rbac --as=alice
kubectl auth can-i delete pods -n cka-rbac --as=alice
```

## Expected evidence

- Positive checks print yes only for intended scope/actions.
- Role rules are namespaced.

## Common traps

- Giving broad `*` verbs/resources because it is faster.
- Forgetting subresources such as `pods/log` may need explicit rule entries.

## Explain it back

State the control-loop/API reason the solution works, and name the first two observations you would use if it did not.
