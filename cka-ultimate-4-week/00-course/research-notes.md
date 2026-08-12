# Research Notes and Course Rationale

**Research date:** 12 August 2026.

## Primary sources

1. Linux Foundation CKA certification page — source of current domain weights, competencies, 2-hour duration, Kubernetes v1.35 environment and simulator entitlement.
2. Linux Foundation CKA/CKAD Important Instructions — source of exam host workflow and provided task-host tools (`kubectl`/`k`, `yq`, `curl`, `wget`, man pages).
3. Linux Foundation exam UI/environment documentation — source of remote desktop/browser constraints and allowed-resource rules.
4. Linux Foundation LFS258 course outline — useful cross-check of expected administrator subject breadth.
5. Upstream Kubernetes documentation — authoritative technical reference for kubeadm, RBAC, etcd, Services, EndpointSlices, DNS, Ingress, NetworkPolicy, storage, HPA, CRDs, troubleshooting and related APIs.
6. Helm and Kubernetes Gateway API documentation — modern curriculum topics explicitly represented in the current CKA competency list.

## What changed compared with older CKA plans

Prep material written around older blueprints can underweight or omit topics that now appear explicitly in the official competencies. This course therefore includes dedicated practical work for:

- Helm and Kustomize;
- Gateway API;
- CRDs and operators;
- CNI/CSI/CRI extension-interface reasoning;
- workload autoscaling;
- highly available control-plane architecture;
- current kubeadm lifecycle work.

## Why troubleshooting appears every week

Troubleshooting is the largest official domain at 30%. More importantly, CKA tasks are operational: a learner who can create a Deployment but cannot explain `Pending`, `CrashLoopBackOff`, empty EndpointSlices, failed DNS, a stopped kubelet, or a broken static Pod is not exam-ready. Each week therefore combines construction and diagnosis.

## Why the course uses VMs

Managed Kubernetes hides exactly the control-plane, kubelet, runtime and kubeadm layers that CKA expects an administrator to understand. Disposable VMs let you deliberately damage those layers and recover them.

## External study guides

Community courses and guides can provide explanations and additional drills, but this repository treats the official curriculum and upstream docs as source of truth. Community material becomes stale quickly when the exam minor and competencies change.

## Integrity

The mock exams and lab tasks in this repository are original. They are designed from public competency objectives, not from recalled, leaked or reconstructed live exam questions.
