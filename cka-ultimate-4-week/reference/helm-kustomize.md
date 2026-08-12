# Helm + Kustomize Reference

## Helm lifecycle

```bash
helm lint ./chart
helm template demo ./chart
helm install demo ./chart -n NS --create-namespace
helm list -A
helm status demo -n NS
helm get values demo -n NS
helm upgrade demo ./chart -n NS --set replicaCount=3
helm history demo -n NS
helm rollback demo REVISION -n NS
helm uninstall demo -n NS
```

Before installing an unfamiliar chart, inspect values/templates and render locally.

## Kustomize lifecycle

```bash
kubectl kustomize path/to/overlay
kubectl apply -k path/to/overlay
kubectl diff -k path/to/overlay
```

Think: reusable **base** plus environment-specific **overlay**. Practise namespace changes, prefixes/suffixes, replica transforms, images, labels and patches. Always render before apply when debugging.
