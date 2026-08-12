# Mock Exam 1 — 17 Tasks / 100 Points / 120 Minutes

Run `bash mocks/setup-mock-01.sh`, confirm it completes, then start the 120-minute timer. Do not inspect the setup script until the mock is scored.

For every task, first respect any named host, namespace and output path. Equivalent correct implementations are acceptable unless a mechanism is explicitly required.

## Task 1 — Scope discipline — 4 points

In namespace `mock1-app`, create Pod `scope-check` using `busybox:1.36` that runs `sleep 3600`. Configure your **current context** to default to namespace `mock1-app`. Save the current context name to `/tmp/mock1-context.txt`.

## Task 2 — Deployment rollout — 7 points

In `mock1-app`, create Deployment `frontend` with 3 replicas using `nginx:1.27`. Update it to a newer pullable nginx tag available in your environment and ensure the rollout succeeds. Then perform a deliberately bad image update using `nginx:definitely-not-real`, identify the failed rollout, and restore the immediately preceding working revision. Final state: 3 Ready replicas on a pullable image. Save rollout history to `/tmp/frontend-history.txt`.

## Task 3 — Configuration — 5 points

In `mock1-app`, create ConfigMap `frontend-config` with `MODE=exam` and Secret `frontend-secret` with `token=mock1`. Update Deployment `frontend` so its container receives them as env vars `MODE` and `TOKEN`. Do not hard-code values in the Pod template.

## Task 4 — Scheduling — 5 points

Create Pod `fast-only` in `mock1-app` using `nginx:1.27`. It must be scheduled using `nodeSelector` onto a node labelled `mockdisk=fast`. Do not use `nodeName`.

## Task 5 — Taint/toleration — 5 points

Taint `worker02` with `dedicated=mock1:NoSchedule`. Create Pod `worker02-agent` in `mock1-app` using `busybox:1.36`, command `sleep 3600`, with a matching toleration and a node selector that places it on `worker02`. Final state must have the Pod Running on worker02. **Remove the taint after verification**; leave the Pod running.

## Task 6 — Repair an application path — 7 points

The existing `mock-broken` Deployment and Service in `mock1-app` should provide HTTP on Service port 80. Repair all faults required for:

- 2 Ready Deployment replicas;
- a non-empty ready EndpointSlice;
- successful HTTP request to `http://mock-broken` from a Pod in the same namespace.

Do not replace the resources with differently named objects.

## Task 7 — DNS evidence — 4 points

From a disposable Pod in namespace `mock1-net`, resolve `mock-broken.mock1-app.svc.cluster.local`. Save the lookup output to `/tmp/mock1-dns.txt`. Do not manually write the resolved IP.

## Task 8 — NetworkPolicy — 7 points

In `mock1-net`, create Deployment `api` (2 `nginx:1.27` replicas) and Service `api` port 80. Create Pods `client-a` labelled `access=api` and `client-b` labelled `access=none`, both BusyBox sleepers. Apply policies so ingress to Pods labelled `app=api` on TCP/80 is allowed from `client-a` but denied from `client-b`. Prove both outcomes.

## Task 9 — Persistent storage — 6 points

In `mock1-storage`, create a 128Mi PVC `data` using a working StorageClass available in the cluster. Create Pod `writer` mounting it at `/data`, write `mock1-storage` to `/data/value`, recreate the Pod as `reader` using the same claim, and ensure `cat /data/value` prints the marker. If the cluster has no dynamic provisioner, create a compatible static PV instead; the end state matters.

## Task 10 — RBAC — 7 points

In `mock1-rbac`, create ServiceAccount `auditor`. It must be able to `get,list,watch` Pods in `mock1-rbac` and `list` Nodes cluster-wide. It must **not** be able to delete Pods or Nodes. Use least-privilege Role/ClusterRole bindings and prove positive and negative permissions with impersonation.

## Task 11 — HPA — 5 points

In `mock1-app`, create Deployment `autoscaled` with image `nginx:1.27`, CPU request `50m`, 1 replica. Create HPA with min 1, max 4, target average CPU utilisation 60%. If resource metrics are unavailable, the HPA object must still be correctly configured and its status/conditions inspected; do not install Metrics Server during the mock.

## Task 12 — Helm — 6 points

Install local chart `assets/charts/cka-web` as release `mock1-web` in namespace `mock1-modern`. Override replica count to 3. Perform an upgrade to replica count 4 and ensure the final Deployment is healthy. Save `helm history` to `/tmp/mock1-helm-history.txt`.

## Task 13 — Kustomize — 6 points

Render `assets/kustomize/overlays/prod` to `/tmp/mock1-prod.yaml`. Apply the overlay. Ensure the resulting prod Deployment has 3 replicas and the resources from the overlay patch. Do not edit the base manifests.

## Task 14 — CRD — 5 points

Install `assets/widgets-crd.yaml`. In `mock1-modern`, create Widget `exam-widget` with `spec.size: 3` and `spec.enabled: true`. Save `kubectl get widget exam-widget -o yaml` to `/tmp/mock1-widget.yaml`. Demonstrate to yourself that `size: 0` would be rejected; do not leave an invalid object.

## Task 15 — Gateway API — 6 points

If Gateway API CRDs exist, in `mock1-modern` create an `HTTPRoute` named `frontend-route` that matches path prefix `/front` and sends to Service `frontend-proxy` port 80. Create `frontend-proxy` as a Service selecting `frontend` Pods in `mock1-app` only if your Gateway implementation/reference model makes that namespace design valid; otherwise create a backend Service in `mock1-modern` that selects a small local backend. Parent the route to an available Gateway. If no usable Gateway exists, create/inspect the route against a clearly named placeholder parent and save `kubectl describe httproute frontend-route -n mock1-modern` to `/tmp/mock1-route.txt`; do not claim live routing. If Gateway API CRDs are absent, write `Gateway API not installed` to that output file and move on.

## Task 16 — Worker NotReady incident — 9 points

Take/confirm a VM snapshot of worker02 if needed, then run **without inspecting it**:

```bash
bash mocks/inject-mock-01-task16.sh
```

`worker02` will become unhealthy. Diagnose the node from controlplane, then node-local evidence. Restore it to `Ready` and verify kubelet and container runtime are active. Save the final `kubectl describe node worker02` Conditions section to `/tmp/mock1-worker02.txt`.

## Task 17 — Control-plane administration — 6 points

On host `controlplane`:

1. Save `sudo kubeadm certs check-expiration` output to `/tmp/mock1-certs.txt`.
2. Save a fresh worker join command to `/tmp/mock1-join.sh` and set mode `600`.
3. Inspect the local etcd static Pod manifest and save the endpoint, CA, client certificate and key paths needed for a local snapshot command to `/tmp/mock1-etcd-inputs.txt`.
4. If etcd snapshot tooling is already available and rehearsed, create and verify `/var/backups/mock1.db`; otherwise do **not** waste the remaining mock installing tooling. The three output files above are still mandatory.

**STOP at 120 minutes. Open the scorecard only after the timer.**
