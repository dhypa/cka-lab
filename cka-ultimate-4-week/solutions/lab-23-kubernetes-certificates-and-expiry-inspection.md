# Solution — Lab 23: Kubernetes Certificates and Expiry Inspection

This is a **reference path**, not the only valid solution. On CKA, satisfy the requested end state and verify it.

## Intended approach

1. Use kubeadm inventory first.
2. Cross-check with openssl.
3. Map certificates to component manifests/kubeconfigs.

## Canonical commands / evidence

```bash
sudo kubeadm certs check-expiration
sudo grep -R "client-certificate\|tls-cert-file" /etc/kubernetes/manifests /etc/kubernetes/*.conf 2>/dev/null | head -30
```

## Expected evidence

- Inventory and direct certificate dates agree.
- No healthy cert is changed during baseline portion.

## Common traps

- Renewing everything without a reason.
- Assuming every Kubernetes credential is managed by `kubeadm certs renew all`.

## Explain it back

State the control-loop/API reason the solution works, and name the first two observations you would use if it did not.
