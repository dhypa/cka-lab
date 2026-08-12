# Troubleshooting Ladder

Do not start by editing. Start by proving where the failure is.

## 0 — Scope

```bash
hostname
kubectl config current-context
kubectl get ns
kubectl get nodes -o wide
```

## 1 — Workload

```bash
kubectl get pod -n NS -o wide
kubectl describe pod POD -n NS
kubectl get events -n NS --sort-by=.lastTimestamp
kubectl logs POD -n NS --all-containers
kubectl logs POD -n NS -c C --previous
```

Ask: scheduled? image pulled? container started? probe passing? config/volume mounted? OOM/CPU/resource issue?

## 2 — Controller

```bash
kubectl get deploy,rs,ds,sts -n NS
kubectl describe deploy NAME -n NS
kubectl rollout status deploy/NAME -n NS
```

Ask: desired replicas? selectors align? rollout stalled? old ReplicaSet healthy?

## 3 — Service path

```bash
kubectl get svc NAME -n NS -o yaml
kubectl get endpointslice -n NS -l kubernetes.io/service-name=NAME -o wide
kubectl get pod -n NS --show-labels
```

Empty endpoints usually send you to selector/readiness/backend existence before DNS.

## 4 — DNS / policy / route

From a disposable Pod:

```bash
nslookup SERVICE.NS.svc.cluster.local
wget -S -O- http://SERVICE.NS.svc.cluster.local:PORT
```

Then inspect:

```bash
kubectl get networkpolicy -A
kubectl get ingress -A
kubectl get gateway,httproute -A 2>/dev/null || true
kubectl -n kube-system get pods -l k8s-app=kube-dns
```

## 5 — Node

```bash
kubectl describe node NODE
kubectl get pod -A -o wide --field-selector spec.nodeName=NODE
sudo systemctl status kubelet --no-pager
sudo journalctl -u kubelet --since '15 min ago' --no-pager
sudo systemctl status containerd --no-pager
```

Check disk/memory/PIDs, runtime, kubelet config/certs and network plugin.

## 6 — Control plane

On a kubeadm control-plane node:

```bash
sudo ls -l /etc/kubernetes/manifests
sudo crictl ps -a
sudo crictl logs CONTAINER_ID
sudo journalctl -u kubelet --since '15 min ago' --no-pager
```

Inspect static Pod manifests carefully. Bad indentation, paths, flags, certificates or ports can remove the API server/scheduler/controller-manager/etcd.

## 7 — Repair and prove

Make one justified change. Re-run the evidence that failed. Then prove the user-facing requirement, not merely `Running` status.
