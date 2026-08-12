# Study Method

## The 70/20/10 split

Aim for roughly:

- **70% terminal work** — creating, breaking, inspecting and repairing.
- **20% documentation retrieval** — locating exact syntax in official references.
- **10% notes/video/explanation** — only enough theory to make terminal work intelligible.

## The lab loop

For every lab use **Predict → Execute → Observe → Verify → Break → Repair → Explain**.

Before a command, predict what object/status should change. After it, inspect evidence. If your prediction was wrong, write why in the error log. This prevents `kubectl` from becoming cargo cult.

## Retrieval practice

At the end of each day close your notes and reproduce three things from memory:

- one object manifest or imperative command;
- one diagnostic ladder;
- one administrative sequence.

Then compare against docs/solutions and correct yourself.

## Spaced repeats

- Day N: new labs.
- Day N+1: 10-minute repeat of yesterday's hardest operation.
- End of week: capstone that recombines the skills without naming the exact commands.
- Week 4: circuits and mocks expose weak areas; remediation is driven by evidence, not preference.

## Error log taxonomy

Tag each miss:

- `syntax` — API/YAML/flag wrong;
- `scope` — wrong namespace/context/host;
- `model` — misunderstood Kubernetes behaviour;
- `diagnostic` — failed to inspect the right evidence;
- `linux` — service/file/network issue;
- `speed` — knew it but took too long;
- `verification` — made a change but did not prove it;
- `docs` — could not find the needed reference quickly.

Week 4 should attack the most frequent tag first.
