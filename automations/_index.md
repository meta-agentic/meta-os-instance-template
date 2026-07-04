---
type: index
tags: [os, automations, layer1]
---
# Automations

The scheduled / triggered half of Layer 1. A skill is invoked on demand; an automation
runs itself — on a **schedule** (cron / launchd / cloud routine) or on an **event** (git
hook, session start, file change).

| Automation | Trigger | Cadence | Runs | Status |
|------------|---------|---------|------|--------|
| Daily standup / retro | schedule (daily) | @daily | [[skills/agile-process/SKILL\|agile-process]] cadence | candidate |
| Backlog ↔ Jira reconcile | schedule or pre-sprint | @daily | `sync.py` (see [[skills/agile-process/SKILL\|agile-process]]) | candidate |
| Graph refresh | file change / pre-sprint | — | [[skills/graphify/SKILL\|graphify]] `--update` / `--watch` | candidate |
| Session memory import | session start | — | [[skills/hooks-automation/SKILL\|hooks-automation]] | candidate |
| Post-edit format/verify | git hook / post-edit | — | [[skills/hooks-automation/SKILL\|hooks-automation]], [[skills/verification-quality/SKILL\|verification-quality]] | candidate |
| OS heartbeat | schedule (daily) | @daily | [meta-os-dashboard](https://github.com/mova77/meta-os-dashboard) `scripts/heartbeat.mjs` — lint + stale-raw + never-run checks → files a [[templates/heartbeat\|heartbeat]] note to `memory/raw/` | candidate |

Executions append one JSON line to `automations/runs.jsonl`
(`{"automation": "<table name>", "ts": "<ISO-8601>", "outcome": "ok|fail", "note": "…"}`);
the [meta-os-dashboard](https://github.com/mova77/meta-os-dashboard) derives last-run from
it (see [[systems/ontology.yaml|ontology.yaml]]'s `automations:` contract).

## Two kinds

- **Local** — cron / git hooks / Claude Code hooks on this machine. Configure in the
  relevant repo's `.claude/settings.json` or `.githooks/`, or a `launchd` plist.
- **Remote** — cloud scheduler routines (survive machine sleep). See the `schedule` skill.

## Classifying a workflow

When you codify a skill, decide: on-demand (stays a skill) or scheduled/triggered (also
gets an automation row here). Record the trigger, cadence, what it runs, and its status.
