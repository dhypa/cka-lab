# Solution — Lab 27: CNI, CRI and CSI Evidence Hunt

This is a **reference path**, not the only valid solution. On CKA, satisfy the requested end state and verify it.

## Intended approach

1. Inventory implementation evidence.
2. Map a Pod through runtime/network/storage layers.
3. Build symptom routing table.

## Canonical commands / evidence

```bash
kubectl get pods -A -o wide
kubectl get csidrivers
kubectl get storageclass -o yaml
ssh worker01 sudo crictl info
```

## Expected evidence

- CRI endpoint/runtime is identifiable.
- CNI config/plugin Pods are identifiable.
- CSI presence or absence is explicit.

## Common traps

- Memorising CNI/CSI/CRI acronym definitions without being able to find them on a node.
- Blaming kubelet for every plugin-controller failure.

## Explain it back

State the control-loop/API reason the solution works, and name the first two observations you would use if it did not.
