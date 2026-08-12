# Solution — Lab 21: ServiceAccounts and Cluster-Scoped RBAC

This is a **reference path**, not the only valid solution. On CKA, satisfy the requested end state and verify it.

## Intended approach

1. Create ServiceAccount and least-privilege roles.
2. Use cluster binding only for Node access.
3. Verify each boundary with impersonation.

## Canonical commands / evidence

```bash
kubectl create sa observer -n cka-rbac
kubectl create clusterrole node-reader --verb=get,list,watch --resource=nodes
kubectl create clusterrolebinding observer-nodes --clusterrole=node-reader --serviceaccount=cka-rbac:observer
kubectl auth can-i list nodes --as=system:serviceaccount:cka-rbac:observer
```

## Expected evidence

- Cluster-scoped Node read works.
- Namespaced Pod read does not leak to other namespaces.

## Common traps

- Using Role for Nodes, which are cluster-scoped.
- Binding cluster-admin to solve a narrow task.

## Explain it back

State the control-loop/API reason the solution works, and name the first two observations you would use if it did not.
