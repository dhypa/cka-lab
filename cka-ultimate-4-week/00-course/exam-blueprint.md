# Current CKA Blueprint — August 2026

## Exam shape

- Performance-based administration tasks in a remote Linux environment.
- 2 hours.
- Current environment: Kubernetes v1.35.
- Tasks identify the host/context on which work must be performed; CKA candidates should expect to SSH to a designated task host.
- Task hosts provide Kubernetes-oriented tools including `kubectl` (and `k` alias), `yq`, `curl`, `wget`, and man pages.
- Allowed web resources are restricted; current guidance includes Kubernetes documentation/blog, Helm documentation, task-specific Quick Reference links, and CKA Gateway API documentation.

## Domain → concrete skill map

### Troubleshooting — 30%

You must be able to:

- establish scope: application, namespace, node, control plane or network;
- inspect events, Pod status/reasons, init containers, probes and previous logs;
- use resource metrics when available;
- diagnose Services using selectors, ports and EndpointSlices;
- diagnose DNS and NetworkPolicy interactions;
- inspect kubelet/container runtime services and logs;
- inspect static Pod manifests and control-plane Pods;
- distinguish an unhealthy workload from an unhealthy node/cluster;
- make the minimum repair and prove recovery.

### Cluster Architecture, Installation & Configuration — 25%

You must be able to:

- understand control-plane/node components and static Pods;
- prepare/build/join/reset nodes with kubeadm;
- manage kubeconfig contexts and credentials;
- create/test RBAC for users and ServiceAccounts;
- inspect certificates;
- back up/restore etcd correctly;
- perform a version-aware kubeadm upgrade procedure;
- drain/uncordon nodes safely;
- understand HA control-plane topology and endpoints;
- use Helm and Kustomize;
- recognise CNI/CSI/CRI responsibilities and inspect their evidence;
- create/use CRDs and understand the role of operators.

### Services & Networking — 20%

You must be able to:

- reason about Pod IPs and Service virtual IPs;
- create/repair ClusterIP, NodePort and LoadBalancer-style Service definitions;
- understand selectors, target ports, endpoints and EndpointSlices;
- test DNS from inside a Pod;
- create and reason about NetworkPolicies;
- create/inspect Ingress resources and understand controller dependency;
- model Gateway API resources (`GatewayClass`, `Gateway`, routes) and inspect status;
- troubleshoot the path client → DNS → Service/Gateway/Ingress → backend.

### Workloads & Scheduling — 15%

You must be able to:

- create and manage Deployments/DaemonSets and Pods;
- perform rollout updates, inspect history and rollback;
- use ConfigMaps and Secrets as env vars and volumes;
- set requests/limits;
- configure readiness/liveness/startup probes;
- use node selectors, affinity, taints and tolerations;
- understand self-healing controller behaviour;
- create/use HorizontalPodAutoscaler when metrics are available.

### Storage — 10%

You must be able to:

- create/bind PVs and PVCs;
- choose access modes and size requirements;
- understand reclaim policy implications;
- use StorageClasses and dynamic provisioning;
- attach claims to workloads and prove data persistence.

## Course weighting

The day count is not proportional to domain weight because skills overlap. Troubleshooting is embedded in nearly every lab and becomes explicit incident work in Week 3. Cluster administration gets an entire week because it is difficult to learn safely from theory alone.
