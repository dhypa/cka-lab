# Mock Exam 2 — 17 Tasks / 100 Points / 120 Minutes

Run `bash mocks/setup-mock-02.sh`, confirm it completes, then start the timer. Do not inspect setup/injector scripts until scoring.

## Task 1 — Deployment + probes — 7 points

In `mock2-app`, create Deployment `portal` with 2 `nginx:1.27` replicas, CPU request `25m`, memory request `32Mi`, and readiness HTTP GET `/` port 80 every 5 seconds. Expose Service `portal` port 80. Final state: 2 Ready replicas and successful HTTP through Service.

## Task 2 — DaemonSet — 5 points

In `mock2-app`, create DaemonSet `node-marker` using `busybox:1.36` with command `sh -c 'hostname; sleep 3600'`. It should run on worker nodes but not require a replica count. Prove one eligible Pod per worker.

## Task 3 — Required node affinity — 5 points

Create Pod `special` in `mock2-app` using `nginx:1.27`. Use **required node affinity**, not nodeSelector/nodeName, to require node label `workload=special`. Final Pod must run on worker02.

## Task 4 — Service troubleshooting — 7 points

Existing Service `svc-bug` in `mock2-app` should expose its nginx Deployment on Service port 8080. Repair the existing resource so an in-namespace client receives HTTP from `http://svc-bug:8080`. Save the final Service YAML to `/tmp/mock2-svc-bug.yaml`.

## Task 5 — Cross-namespace DNS — 5 points

Create namespace `mock2-net` (already present after setup) client Pod `dns-client` as a BusyBox sleeper. From it, resolve `portal.mock2-app.svc.cluster.local` and save only the lookup output to `/tmp/mock2-dns.txt`. Also prove TCP/HTTP to the Service.

## Task 6 — NetworkPolicy — 7 points

In `mock2-net`, create Deployment+Service `internal` (`nginx:1.27`, port 80). Create BusyBox Pods `trusted` label `role=trusted` and `other` label `role=other`. Configure ingress so `internal` accepts TCP/80 from `trusted` but not `other`. Do not delete the policy after testing.

## Task 7 — Static storage — 5 points

Create a static PV `mock2-pv` of 128Mi with `ReadWriteOnce`, StorageClass name `mock2-static`, reclaim policy `Retain`, backed by `/tmp/mock2-pv` for this lab. In `mock2-storage`, create matching PVC `mock2-pvc` requesting 64Mi. Ensure it binds. Do not delete the claim before scoring.

## Task 8 — ServiceAccount RBAC — 6 points

In `mock2-rbac`, ServiceAccount `viewer` must be allowed `get,list` ConfigMaps and Secrets in that namespace, but **not** update/delete them and not read Secrets in `default`. Prove at least one positive and two negative `auth can-i` checks. Use namespaced RBAC only.

## Task 9 — Node maintenance — 6 points

Cordon `worker01`. Confirm new general workload will not schedule there. Save the node's `spec.unschedulable` value to `/tmp/mock2-worker01.txt`. Then uncordon it. Final state must be schedulable.

## Task 10 — Helm rollback — 6 points

Install local chart `assets/charts/cka-web` as release `mock2-web` in `mock2-modern` with 2 replicas. Upgrade to 3 replicas. Then perform an upgrade with invalid image tag `definitely-not-real`, observe failed workload, and roll back to the 3-replica working revision. Save Helm history to `/tmp/mock2-helm.txt`.

## Task 11 — Kustomize customisation — 7 points

Without modifying `assets/kustomize/base`, create a new temporary overlay under `/tmp/mock2-overlay` that uses the base, namespace `mock2-modern`, prefix `m2-`, and 2 replicas. Render it to `/tmp/mock2-kustomized.yaml`, apply it, and verify the Deployment is Ready.

## Task 12 — Control-plane scheduler incident — 8 points

Take/confirm a controlplane snapshot and run, without inspecting:

```bash
bash mocks/inject-mock-02-task12.sh
```

New unscheduled Pods will stop being assigned to nodes because the scheduler static Pod is missing. Diagnose using API status where available plus **controlplane node-local static-Pod evidence**, restore the scheduler, and prove a newly created Pod can be scheduled. Save final `kube-system` scheduler Pod status to `/tmp/mock2-scheduler.txt`.

## Task 13 — CRD validation — 6 points

Install Widget CRD from `assets/widgets-crd.yaml`. In `mock2-modern`, create Widget `m2` with size 5 enabled false. Save `kubectl explain widget.spec` output to `/tmp/mock2-widget-explain.txt`. Attempt an invalid size 0 object and ensure it is rejected/not persisted.

## Task 14 — HPA — 5 points

Create Deployment `scale-me` in `mock2-app` with CPU request `40m`. Create HPA min 2, max 6, CPU target 55%. Exact metric availability is not required; exact spec is.

## Task 15 — Gateway API status — 5 points

If Gateway API CRDs exist, list GatewayClasses and create an HTTPRoute `m2-route` in `mock2-modern` matching `/m2` with a valid backend Service you create in that namespace. Parent to an available Gateway if possible, otherwise a placeholder. Save `kubectl describe httproute m2-route` to `/tmp/mock2-route.txt`. If APIs are absent, write `Gateway API not installed` to that file and move on.

## Task 16 — kubeadm/certificates — 6 points

On `controlplane`, save node names+kubelet versions to `/tmp/mock2-versions.txt`, certificate expiration report to `/tmp/mock2-certs.txt`, and a fresh worker join command to `/tmp/mock2-join.sh` mode 600.

## Task 17 — etcd backup evidence — 4 points

On `controlplane`, inspect the local etcd static Pod and save to `/tmp/mock2-etcd.txt`: data directory, local client endpoint, trusted CA path, client certificate path, and key path. If your etcd snapshot tooling is ready, create/verify `/var/backups/mock2.db`. Snapshot is recommended but this mock task scores the correct inputs/evidence so tool installation does not dominate the clock.

**STOP at 120 minutes. Score only the timed state.**
