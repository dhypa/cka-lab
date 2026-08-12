# kubectl Speed Reference

## Safety first

```bash
hostname
kubectl config current-context
kubectl config view --minify
```

## Generate instead of type

```bash
kubectl run tmp --image=busybox:1.36 --restart=Never --dry-run=client -o yaml
kubectl create deployment web --image=nginx:1.27 --replicas=3 --dry-run=client -o yaml
kubectl expose deployment web --port=80 --target-port=80 --dry-run=client -o yaml
kubectl create configmap app-config --from-literal=MODE=production --dry-run=client -o yaml
kubectl create secret generic app-secret --from-literal=token=abc --dry-run=client -o yaml
kubectl create serviceaccount reader --dry-run=client -o yaml
kubectl create role pod-reader --verb=get,list,watch --resource=pods --dry-run=client -o yaml
kubectl create rolebinding read-pods --role=pod-reader --serviceaccount=ns:reader --dry-run=client -o yaml
```

## Fast inspection

```bash
k get po -A -o wide
k get events -A --sort-by=.lastTimestamp
k describe po NAME
k logs NAME
k logs NAME -c CONTAINER --previous
k get deploy NAME -o yaml
k get svc,endpointslice
k auth can-i get pods --as=system:serviceaccount:NS:SA -n NS
```

## Patch/edit patterns

```bash
kubectl set image deployment/web web=nginx:1.28
kubectl scale deployment/web --replicas=4
kubectl rollout status deployment/web
kubectl rollout history deployment/web
kubectl rollout undo deployment/web
kubectl label node worker01 disk=ssd
kubectl taint node worker02 dedicated=infra:NoSchedule
kubectl cordon worker01
kubectl drain worker01 --ignore-daemonsets --delete-emptydir-data
kubectl uncordon worker01
```

## Output extraction

Practise JSONPath rather than inventing it during the exam:

```bash
kubectl get nodes -o jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.status.nodeInfo.kubeletVersion}{"\n"}{end}'
kubectl get pod NAME -o jsonpath='{.spec.nodeName}{"\n"}'
```

Use `-o yaml` + `yq` when that is clearer and faster.
