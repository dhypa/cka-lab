# Start Here

## What passing requires

CKA is not primarily a Kubernetes trivia test. You need four things simultaneously:

1. **A correct mental model** of Kubernetes resources and control loops.
2. **Operational fluency** with `kubectl`, Linux services/files, kubeadm, logs and network diagnostics.
3. **Troubleshooting discipline** that narrows faults instead of randomly changing things.
4. **Exam execution**: host/context checks, fast documentation retrieval, verification, timeboxing and recovery from mistakes.

The 4-week course trains all four every week.

## Before Day 1

You should already be comfortable with a Linux shell, SSH, files, pipes, permissions, `systemctl`/`journalctl`, a terminal editor, basic TCP/IP concepts, YAML indentation and containers. You do **not** need to be a Kubernetes expert.

Run labs from the **repository root** unless a task explicitly changes directory; paths such as `assets/...` assume that working directory.

Run this baseline on your practice environment:

```bash
hostname
kubectl config current-context
kubectl get nodes -o wide
kubectl get pods -A
kubectl version
```

If you do not yet have a cluster, build the environment in [`lab-environment.md`](lab-environment.md). Do not spend days perfecting the lab platform; a disposable kubeadm cluster is the course instrument, not the course itself.

## Daily loop

For each day:

1. Read only the named reference material.
2. Do the labs cold.
3. If blocked for 5–8 minutes, use official docs before solutions.
4. Verify the result explicitly.
5. Record commands/errors you could not explain.
6. Reset the environment required by the next lab.
7. Re-run one failed task from memory at the end of the day.

## Scoring yourself

Use three states in `progress.md`:

- **Green** — can perform it from a short task statement, verify it, and repair a common failure without a walkthrough.
- **Amber** — can complete it with docs but slowly or unreliably.
- **Red** — need a tutorial/solution or cannot diagnose failures.

Your goal by Day 28 is no Red skill in an official domain, and at least **75/100 on both internal mocks** with time left for review. The 75% threshold is a course readiness target, not an assertion about the Linux Foundation's official pass score.

## What not to do

Do not spend four weeks watching Kubernetes videos. Do not memorise giant YAML manifests. Do not practise only on a managed cluster where control-plane failures are hidden. Do not rely on `kubectl get pods` as your entire troubleshooting method. Do not skip cleanup/verification sections: those are part of the lab.
