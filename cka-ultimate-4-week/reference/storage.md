# Storage Reference

## Binding checklist

For a Pending PVC inspect:

```bash
kubectl get pv,pvc -A
kubectl describe pvc CLAIM -n NS
kubectl get storageclass
kubectl get events -n NS --sort-by=.lastTimestamp
```

Check requested size, access modes, `storageClassName`, selectors (if any), provisioner behaviour and available PV capacity.

## Reclaim policy

`Retain` means underlying storage is not automatically discarded when the claim is deleted; admin cleanup/reclaim work remains. `Delete` generally lets the storage implementation remove dynamically provisioned backing storage. Understand the implication before deleting claims.

## Dynamic provisioning

A StorageClass identifies a provisioner and policy/config. A PVC requesting that class can trigger provisioning. A class object without a working CSI/in-tree provisioner does not magically create storage.

## Workload proof

Always mount the claim in a Pod, write data, recreate/reschedule as appropriate, and prove persistence. `Bound` is necessary but not sufficient for an application-storage task.
