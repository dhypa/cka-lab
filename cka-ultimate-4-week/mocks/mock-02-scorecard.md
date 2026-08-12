# Mock 2 Scorecard — 100 Points

| Task | Pts | Verification / scoring |
|---:|---:|---|
| 1 | 7 | 2 Ready + resources/probe correct (5), Service HTTP (2) |
| 2 | 5 | DaemonSet semantics (2), one eligible worker Pod each (3) |
| 3 | 5 | required affinity mechanism (2), Running worker02 (3) |
| 4 | 7 | existing Service repaired (3), HTTP 8080 (2), output YAML (2) |
| 5 | 5 | FQDN output file (3), HTTP proof (2) |
| 6 | 7 | policy/selectors/port (3), trusted succeeds (2), other denied (2) |
| 7 | 5 | PV spec/reclaim/class (3), PVC Bound (2) |
| 8 | 6 | correct namespaced read (3), both negative boundaries (3) |
| 9 | 6 | cordon evidence file (2), scheduling intent observed (2), final uncordon (2) |
| 10 | 6 | install+working upgrade (2), failed image observed then rollback (2), healthy 3 replicas+history file (2) |
| 11 | 7 | new overlay/base reference (2), namespace/prefix/replicas transforms (3), rendered file+Ready apply (2) |
| 12 | 8 | scheduler absence diagnosed node-locally (3), manifest restored (2), newly created Pod schedules (2), status file (1) |
| 13 | 6 | CRD/valid Widget (2), explain file (2), invalid rejected (2) |
| 14 | 5 | request present (1), HPA min/max/55 target exact (4) |
| 15 | 5 | correct capability branch (2), route/backend/status output (3) |
| 16 | 6 | versions (2), certs (2), 600 join command (2) |
| 17 | 4 | all five etcd inputs correct from live manifest (4); snapshot is unscored extra proof |

**Raw score: ____ / 100**  
**Time used: ____ / 120 min**  
**Course gate met (≥75): yes / no**

## Error taxonomy

| Task | Points lost | tag | exact cause | remediation lab |
|---|---:|---|---|---|
| | | | | |
