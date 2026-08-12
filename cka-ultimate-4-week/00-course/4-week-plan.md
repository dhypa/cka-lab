# Four-Week Plan

Assume roughly **2–3 focused hours on weekdays** and **3–4 hours on capstone/mock days**. If you have less time, preserve the labs and reduce reading/video time first.

| Day | Focus | Required work | Exit condition |
|---:|---|---|---|
| 1 | Safety + resource generation | Labs 01–03 | Can generate/edit objects and never lose host/context awareness |
| 2 | Pod observation + config | Labs 04–05 | Can get useful evidence from events/logs and inject config correctly |
| 3 | Reliability + rollouts | Labs 06–08 | Can repair probes and perform rollout/rollback/self-healing work |
| 4 | Scheduling | Labs 09–10 | Can constrain placement and explain why a Pod is Pending |
| 5 | Service discovery | Labs 11–12 | Can trace selector → EndpointSlice → DNS → backend |
| 6 | Storage | Labs 13–14 | Can bind/use claims and reason about provisioning/reclaim |
| 7 | Capstone 1 | Lab 15 + skill matrix | Build/debug a small stateful app without walkthrough |
| 8 | Architecture + bootstrap | Labs 16–17 | Can identify components and build a kubeadm cluster |
| 9 | Node lifecycle + kubeconfig | Labs 18–19 | Can reset/rejoin and manipulate contexts safely |
| 10 | RBAC | Labs 20–21 | Can create/test namespaced and cluster-scoped permissions |
| 11 | etcd + certs | Labs 22–23 | Can create/verify a snapshot and inspect cert expiry |
| 12 | Maintenance + upgrade | Labs 24–25 | Can drain and execute a version-aware upgrade sequence |
| 13 | Modern admin toolkit | Labs 26–29 | Can reason about HA/interfaces and operate Helm/Kustomize |
| 14 | Capstone 2 | Lab 30 + skill matrix | Recover/maintain platform from mixed admin faults |
| 15 | Network path + policy | Labs 31–32 | Can prove connectivity and enforce default-deny/allow rules |
| 16 | Ingress + Gateway | Labs 33–34 | Can construct/inspect both API models and controller dependencies |
| 17 | Advanced routing | Labs 35–36 | Can reason about route matching/weights and EndpointSlices |
| 18 | Extensibility + autoscaling | Labs 37–39 | Can create CRD, inspect operator and configure HPA |
| 19 | App incidents | Labs 40–41 | Can triage resource/log/event evidence and repair app faults |
| 20 | Infra incidents | Labs 42–44 | Can isolate network, node and control-plane faults methodically |
| 21 | Capstone 3 | Lab 45 + skill matrix | Recover a multi-layer outage with a written evidence trail |
| 22 | Speed + exam mechanics | Labs 46–47 | Commands and host/context discipline are automatic |
| 23 | Timed circuits | Labs 48–49 | Networking/admin circuits fit their timeboxes |
| 24 | Modern topics + docs | Labs 50–51 | Can retrieve needed official syntax rapidly |
| 25 | Mock 1 | Lab 52 + Mock 1 | Complete 17 tasks in 120 minutes and score objectively |
| 26 | Remediation | Lab 53 | Rebuild every missed skill from blank state twice |
| 27 | Mock 2 + simulator protocol | Lab 54 + Mock 2; use simulator if scheduled | Second full timed result shows improvement |
| 28 | Readiness gate | Lab 55 | No Red blueprint skills; internal mock target met; exam routine fixed |

## Every evening — 15 minutes

- One command-generation drill.
- One `kubectl describe`/events/logs diagnosis.
- One official-doc retrieval race.
- Update the error log.

## Weekly capstones

Capstones intentionally avoid telling you which exact resource/command solves each requirement. They test whether isolated skills have become administrator behaviour.
