# CKA Ultimate 4-Week Course

**Build date:** 12 August 2026  
**Target exam environment:** Certified Kubernetes Administrator (CKA), Kubernetes v1.35  
**Format:** 28 days, 55 hands-on labs, 3 capstones, 2 original timed mock exams, solution set, reusable manifests, and troubleshooting references.

This repository is designed to be worked through, not merely read. Every practical exercise is written as a lab with a scenario, starting-state checks, tasks, success criteria, verification, a documentation drill, a failure/stretch exercise, cleanup/reset instructions, and debrief questions.

## Current official exam map

The Linux Foundation currently lists these CKA domains:

| Domain | Weight |
|---|---:|
| Troubleshooting | 30% |
| Cluster Architecture, Installation & Configuration | 25% |
| Services & Networking | 20% |
| Workloads & Scheduling | 15% |
| Storage | 10% |

The current CKA environment is Kubernetes **v1.35** and the exam is **2 hours** of performance-based tasks. Current competencies explicitly cover kubeadm, RBAC, highly available control planes, Helm, Kustomize, CNI/CSI/CRI, CRDs/operators, Gateway API, autoscaling, storage, networking, and troubleshooting.

> Exam details change. Re-check the Linux Foundation CKA page and Important Instructions shortly before your exam rather than relying on this build forever.

## Start here

1. Read [`00-course/START-HERE.md`](00-course/START-HERE.md).
2. Build or restore the lab environment described in [`00-course/lab-environment.md`](00-course/lab-environment.md).
3. Baseline yourself against [`00-course/skill-matrix.md`](00-course/skill-matrix.md).
4. Work the daily schedule in [`00-course/4-week-plan.md`](00-course/4-week-plan.md).
5. Do labs without the solutions first. Solutions live separately in [`solutions/`](solutions/).
6. Record every failure mode in [`00-course/error-log.md`](00-course/error-log.md).
7. Treat the two mocks as real 120-minute exams.

## Course rules

- **Type commands.** Do not turn the course into copy/paste theatre.
- **Verify everything.** Creating an object is not the same as proving it works.
- **Break things deliberately.** CKA troubleshooting is too heavily weighted to leave failure diagnosis until the final week.
- **Use the docs under time pressure.** The goal is not memorisation of YAML; it is fast retrieval plus reliable execution.
- **Practise host/context discipline.** A technically correct command on the wrong host or cluster is still wrong.
- **Snapshot before destructive control-plane labs.** Several labs intentionally damage kubelet/static-pod/control-plane state.
- **Keep an error log.** Your repeated mistakes determine what you revise in Week 4.

## Repository map

- `00-course/` — blueprint, skill matrix, plan, setup, exam strategy and tracking.
- `01-week-1-core-objects/` — workloads, scheduling, Services, DNS and storage fundamentals.
- `02-week-2-cluster-admin/` — kubeadm, RBAC, etcd, upgrades, HA reasoning, Helm/Kustomize and extension interfaces.
- `03-week-3-networking-debug/` — NetworkPolicy, Ingress, Gateway API, CRDs/operators, HPA and incident response.
- `04-week-4-exam-mode/` — speed, docs navigation, timed circuits, mocks and readiness gate.
- `assets/` — manifests, a local Helm chart and Kustomize examples.
- `reference/` — concise exam-oriented runbooks.
- `scripts/` — safe practice helpers.
- `mocks/` — two 17-task original mock exams and scorecards.
- `projects/` — index of the three capstone projects.
- `solutions/` — solution notes for all 55 labs.
- `FILE-INDEX.md` — complete repository index.

Optional external material is curated in [`00-course/external-resources.md`](00-course/external-resources.md).

## Source policy

This course is built from the public CKA curriculum, Linux Foundation exam guidance, and upstream Kubernetes/Helm/Gateway API documentation. The mock tasks are original practice problems; there are no leaked or reconstructed live exam questions.

See [`00-course/research-notes.md`](00-course/research-notes.md) for the source list and design rationale.
