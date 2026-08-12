# Solution — Lab 44: Incident: Control Plane Static Pod Failure

This is a **reference path**, not the only valid solution. On CKA, satisfy the requested end state and verify it.

## Intended approach

1. Backup manifest outside watched directory.
2. Inject one invalid flag.
3. Use `journalctl -u kubelet`, `crictl ps -a`, `crictl logs` and file inspection.
4. Remove bad flag; verify API ready.

## Canonical commands / evidence

```bash
ssh controlplane "sudo journalctl -u kubelet --since '10 min ago' --no-pager | tail -100"
ssh controlplane "sudo crictl ps -a | head -20"
kubectl get --raw=/readyz?verbose
```

## Expected evidence

- API recovers automatically when valid static Pod desired state is restored.
- Kubelet/runtime logs reveal repeated container failure.

## Common traps

- Saving backup copy inside `/etc/kubernetes/manifests` where kubelet may treat it as another static Pod manifest.
- Using YAML formatting/editor autosave files in watched directory.

## Explain it back

State the control-loop/API reason the solution works, and name the first two observations you would use if it did not.
