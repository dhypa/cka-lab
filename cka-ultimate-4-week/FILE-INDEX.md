# File Index

**Files:** 169  
**Labs:** 55  
**Solutions:** 55  

## Entry points

- [`README.md`](README.md) — course overview and repository map.
- [`00-course/START-HERE.md`](00-course/START-HERE.md) — how to work the course.
- [`00-course/4-week-plan.md`](00-course/4-week-plan.md) — day-by-day schedule.
- [`00-course/skill-matrix.md`](00-course/skill-matrix.md) — pass-skill checklist.
- [`projects/README.md`](projects/README.md) — capstones.
- [`mocks/README.md`](mocks/README.md) — timed exam protocol.
- [`reference/exam-day-checklist.md`](reference/exam-day-checklist.md) — final-day checklist.

## Complete tree

```text
00-course/
  4-week-plan.md
  START-HERE.md
  docs-index.md
  error-log.md
  exam-blueprint.md
  exam-strategy.md
  external-resources.md
  lab-environment.md
  progress.md
  research-notes.md
  skill-matrix.md
  study-method.md
01-week-1-core-objects/
  README.md
  day-01/
    lab-01-host-context-and-namespace-safety.md
    lab-02-imperative-generators-to-declarative-yaml.md
    lab-03-labels-selectors-and-controller-ownership.md
  day-02/
    lab-04-pod-lifecycle-events-logs-and-previous-logs.md
    lab-05-configmaps-and-secrets-as-environment-and-volumes.md
  day-03/
    lab-06-requests-limits-and-self-healing-probes.md
    lab-07-deployment-rollouts-and-rollbacks.md
    lab-08-daemonsets-and-controller-self-healing.md
  day-04/
    lab-09-nodeselector-and-node-affinity.md
    lab-10-taints-tolerations-and-maintenance-intent.md
  day-05/
    lab-11-services-ports-and-endpointslices.md
    lab-12-coredns-and-service-discovery.md
  day-06/
    lab-13-static-pv-pvc-binding-and-reclaim-policies.md
    lab-14-storageclasses-and-dynamic-provisioning.md
  day-07/
    lab-15-week-1-capstone-ship-a-stateful-web-tier.md
02-week-2-cluster-admin/
  README.md
  day-08/
    lab-16-control-plane-and-static-pod-anatomy.md
    lab-17-build-a-multi-node-cluster-with-kubeadm.md
  day-09/
    lab-18-worker-join-reset-and-rejoin.md
    lab-19-kubeconfig-contexts-and-client-identity.md
  day-10/
    lab-20-namespaced-rbac-and-authorization-testing.md
    lab-21-serviceaccounts-and-cluster-scoped-rbac.md
  day-11/
    lab-22-etcd-snapshot-and-restore.md
    lab-23-kubernetes-certificates-and-expiry-inspection.md
  day-12/
    lab-24-cordon-drain-and-uncordon.md
    lab-25-kubeadm-cluster-upgrade-procedure.md
  day-13/
    lab-26-highly-available-control-plane-reasoning.md
    lab-27-cni-cri-and-csi-evidence-hunt.md
    lab-28-helm-install-upgrade-and-rollback.md
    lab-29-kustomize-bases-overlays-and-patches.md
  day-14/
    lab-30-week-2-capstone-recover-and-maintain-the-platform.md
03-week-3-networking-debug/
  README.md
  day-15/
    lab-31-pod-to-pod-and-service-network-path.md
    lab-32-networkpolicy-default-deny-then-explicit-allow.md
  day-16/
    lab-33-ingress-resource-and-controller-path.md
    lab-34-gateway-api-gatewayclass-gateway-and-httproute.md
  day-17/
    lab-35-gateway-api-matching-weights-and-cross-namespace-thinking.md
    lab-36-endpointslices-and-selector-less-services.md
  day-18/
    lab-37-customresourcedefinition-and-schema-validation.md
    lab-38-install-and-inspect-an-operator.md
    lab-39-horizontal-pod-autoscaling.md
  day-19/
    lab-40-resource-usage-logs-and-events-triage.md
    lab-41-incident-broken-application-deployment.md
  day-20/
    lab-42-incident-service-dns-and-policy-failure.md
    lab-43-incident-worker-node-notready.md
    lab-44-incident-control-plane-static-pod-failure.md
  day-21/
    lab-45-week-3-capstone-multi-layer-outage.md
04-week-4-exam-mode/
  README.md
  day-22/
    lab-46-timed-kubectl-resource-speed-drill.md
    lab-47-exam-style-ssh-host-and-context-drill.md
  day-23/
    lab-48-timed-networking-circuit.md
    lab-49-timed-cluster-administration-circuit.md
  day-24/
    lab-50-timed-modern-cka-topics-circuit.md
    lab-51-official-documentation-navigation-race.md
  day-25/
    lab-52-mock-exam-preflight-and-scoring-discipline.md
  day-26/
    lab-53-mock-1-remediation-laboratory.md
  day-27/
    lab-54-killer-sh-attempt-protocol.md
  day-28/
    lab-55-final-readiness-gate.md
README.md
assets/
  broken-deployment.yaml
  broken-service.yaml
  charts/
    cka-web/
      Chart.yaml
      templates/
        _helpers.tpl
        deployment.yaml
        service.yaml
      values.yaml
  gateway/
    README.md
  kustomize/
    base/
      deployment.yaml
      kustomization.yaml
      service.yaml
    overlays/
      dev/
        kustomization.yaml
      prod/
        kustomization.yaml
  networkpolicy-seed.yaml
  storage-static.yaml
  widgets-crd.yaml
course-manifest.json
mocks/
  README.md
  inject-mock-01-task16.sh
  inject-mock-02-task12.sh
  mock-01-scorecard.md
  mock-01-solutions.md
  mock-01.md
  mock-02-scorecard.md
  mock-02-solutions.md
  mock-02.md
  setup-mock-01.sh
  setup-mock-02.sh
projects/
  README.md
reference/
  exam-day-checklist.md
  gateway-api.md
  helm-kustomize.md
  kubeadm.md
  kubectl-speed.md
  linux-node-debugging.md
  networking.md
  storage.md
  troubleshooting-ladder.md
scripts/
  cluster-health.sh
  exam-shell.sh
  reset-practice-namespaces.sh
  verify-course.py
solutions/
  lab-01-host-context-and-namespace-safety.md
  lab-02-imperative-generators-to-declarative-yaml.md
  lab-03-labels-selectors-and-controller-ownership.md
  lab-04-pod-lifecycle-events-logs-and-previous-logs.md
  lab-05-configmaps-and-secrets-as-environment-and-volumes.md
  lab-06-requests-limits-and-self-healing-probes.md
  lab-07-deployment-rollouts-and-rollbacks.md
  lab-08-daemonsets-and-controller-self-healing.md
  lab-09-nodeselector-and-node-affinity.md
  lab-10-taints-tolerations-and-maintenance-intent.md
  lab-11-services-ports-and-endpointslices.md
  lab-12-coredns-and-service-discovery.md
  lab-13-static-pv-pvc-binding-and-reclaim-policies.md
  lab-14-storageclasses-and-dynamic-provisioning.md
  lab-15-week-1-capstone-ship-a-stateful-web-tier.md
  lab-16-control-plane-and-static-pod-anatomy.md
  lab-17-build-a-multi-node-cluster-with-kubeadm.md
  lab-18-worker-join-reset-and-rejoin.md
  lab-19-kubeconfig-contexts-and-client-identity.md
  lab-20-namespaced-rbac-and-authorization-testing.md
  lab-21-serviceaccounts-and-cluster-scoped-rbac.md
  lab-22-etcd-snapshot-and-restore.md
  lab-23-kubernetes-certificates-and-expiry-inspection.md
  lab-24-cordon-drain-and-uncordon.md
  lab-25-kubeadm-cluster-upgrade-procedure.md
  lab-26-highly-available-control-plane-reasoning.md
  lab-27-cni-cri-and-csi-evidence-hunt.md
  lab-28-helm-install-upgrade-and-rollback.md
  lab-29-kustomize-bases-overlays-and-patches.md
  lab-30-week-2-capstone-recover-and-maintain-the-platform.md
  lab-31-pod-to-pod-and-service-network-path.md
  lab-32-networkpolicy-default-deny-then-explicit-allow.md
  lab-33-ingress-resource-and-controller-path.md
  lab-34-gateway-api-gatewayclass-gateway-and-httproute.md
  lab-35-gateway-api-matching-weights-and-cross-namespace-thinking.md
  lab-36-endpointslices-and-selector-less-services.md
  lab-37-customresourcedefinition-and-schema-validation.md
  lab-38-install-and-inspect-an-operator.md
  lab-39-horizontal-pod-autoscaling.md
  lab-40-resource-usage-logs-and-events-triage.md
  lab-41-incident-broken-application-deployment.md
  lab-42-incident-service-dns-and-policy-failure.md
  lab-43-incident-worker-node-notready.md
  lab-44-incident-control-plane-static-pod-failure.md
  lab-45-week-3-capstone-multi-layer-outage.md
  lab-46-timed-kubectl-resource-speed-drill.md
  lab-47-exam-style-ssh-host-and-context-drill.md
  lab-48-timed-networking-circuit.md
  lab-49-timed-cluster-administration-circuit.md
  lab-50-timed-modern-cka-topics-circuit.md
  lab-51-official-documentation-navigation-race.md
  lab-52-mock-exam-preflight-and-scoring-discipline.md
  lab-53-mock-1-remediation-laboratory.md
  lab-54-killer-sh-attempt-protocol.md
  lab-55-final-readiness-gate.md
```

## Sanity check

Run:

```bash
./scripts/verify-course.py
```

It checks lab count/numbering, day coverage, required lab sections, local lab→solution links, solution count, and executable helper permissions.
