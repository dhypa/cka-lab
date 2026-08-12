# Exam-Day Checklist

## Before launch

- Re-read the current Linux Foundation Important Instructions and allowed-resource policy.
- Complete system/environment checks required by the provider.
- Use a stable network, power connection and permitted single-monitor setup.
- Have acceptable ID ready.
- Do not depend on local notes/tools that are not permitted inside the secure environment.

## Per task

1. Read host/context/namespace and output filename requirements.
2. `hostname`; check current context.
3. Solve the smallest correct version of the task.
4. Verify it.
5. If stuck, mark/skip rather than burn unlimited time.
6. Exit task host when done if you SSHed into it.

## Final review

- Revisit high-value tasks.
- Check saved output files exist and contain requested data.
- Check resources were created in the requested namespace/context.
- Verify rollouts, RBAC (`can-i`), endpoints/connectivity, and node health where relevant.
- Do not “clean up” resources unless the task asks you to.
