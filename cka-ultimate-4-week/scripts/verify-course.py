#!/usr/bin/env python3
from pathlib import Path
import re, sys
root=Path(__file__).resolve().parents[1]
labs=sorted(root.glob('0[1-4]-week-*/day-*/lab-*.md'))
solutions=sorted((root/'solutions').glob('lab-*.md'))
required=['## Objective','## Scenario','## Prerequisites','## Safety / starting-state check','## Lab setup','## Tasks','## Success criteria','## Verification','## Documentation drill','## Failure injection / stretch','## Cleanup / reset','## Debrief','## Solution']
errors=[]
if len(labs)!=55: errors.append(f'expected 55 labs, found {len(labs)}')
if len(solutions)!=55: errors.append(f'expected 55 solutions, found {len(solutions)}')
nums=[]; days=[]
for p in labs:
    m=re.search(r'lab-(\d+)-',p.name); nums.append(int(m.group(1)))
    dm=re.search(r'day-(\d+)',str(p)); days.append(int(dm.group(1)))
    text=p.read_text()
    for h in required:
        if h not in text: errors.append(f'{p.relative_to(root)} missing {h}')
    for target in re.findall(r'\]\(([^)]+\.md)\)',text):
        if '://' in target: continue
        if not (p.parent/target).resolve().exists(): errors.append(f'broken link {target} in {p.relative_to(root)}')
if nums!=list(range(1,56)): errors.append(f'lab numbers not exactly 1..55: {nums}')
if sorted(set(days))!=list(range(1,29)): errors.append(f'days not exactly 1..28: {sorted(set(days))}')
for p in root.glob('scripts/*'):
    if p.suffix in {'.sh','.py'} and not (p.stat().st_mode & 0o111): errors.append(f'not executable: {p.relative_to(root)}')
if errors:
    print('COURSE QA FAILED')
    print('\n'.join('- '+e for e in errors))
    sys.exit(1)
print(f'COURSE QA OK: {len(labs)} labs, {len(solutions)} solutions, days {min(days)}-{max(days)}')
