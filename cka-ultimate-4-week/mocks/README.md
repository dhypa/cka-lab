# Mock Exams

These are **original practice exams** based on public CKA competency areas. They are not live, recalled, reconstructed or leaked exam questions.

## Rules

- 120 minutes, hard stop.
- Start from a healthy `10-cluster-ready`-style snapshot unless the mock says otherwise.
- Use terminal/editor plus only the official documentation resources currently allowed by the Linux Foundation exam rules.
- Do not open `solutions/`, mock solutions, lab files, or personal walkthrough notes during the timer.
- Read host/context/namespace/output requirements literally.
- Skip and return rather than allowing one task to consume the mock.
- At 120 minutes stop typing changes. Then score from live state.

## Internal readiness threshold

This course uses **75/100** as a conservative internal gate for each mock, plus no repeated host/context errors and no Red skill-matrix rows. This is a course policy, **not** a statement of the Linux Foundation's official passing score.

## Before each mock

```bash
hostname
kubectl config current-context
kubectl get nodes -o wide
kubectl get pods -A
```

Run the mock setup script before the timer where specified. Do **not** inspect the setup/injector script first; it exists to create unknown failures. You may inspect it after scoring.

## Destructive injectors

Some late tasks have a separate injector. The task tells you exactly when to execute it. This keeps earlier tasks independent while still creating a real node/control-plane incident. Always use disposable VMs/snapshots.
