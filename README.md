# meta-os instance template

A ready-to-use skeleton for bootstrapping your own private **Agentic OS instance** on top
of the public [meta-os](https://github.com/mova77/meta-os) framework. This is the
*instance* side of the framework/instance split: your project registry, memory, and
automations — the framework's skills/systems/templates/agents mount in by symlink.

## Use this template

1. Click **Use this template → Create a new repository** above (or `gh repo create
   <you>/<instance-name> --template mova77/meta-os-instance-template --private`).
   **Keep the new repo private** — this is where your real, non-public data will live.
2. Clone it **as a sibling of a `meta-os` checkout** — the symlinks (`skills/`,
   `systems/`, `templates/`, `agents/`) are relative paths (`../meta-os/...`) and only
   resolve when the two repos sit next to each other:
   ```
   code/
   ├── meta-os/              (git clone git@github.com:mova77/meta-os.git)
   └── <instance-name>/      (your new instance, cloned here)
   ```
   If you cloned it somewhere else, move it or re-point the four symlinks.
3. Rename `{{instance-name}}` in `CLAUDE.md` and `_index.md` to your actual instance name,
   and fill in the "Instance facts" section of `CLAUDE.md` (your estate, authority order
   if you use the agile-process skill).
4. Open the instance repo (not `meta-os`) as your Obsidian vault — wikilinks resolve
   across both repos because they're vault-root-relative.
5. For machine-global skill discovery in Claude Code:
   ```bash
   for s in meta-os/skills/*/; do
     ln -s "$(pwd)/$s" ~/.claude/skills/"$(basename "$s")"
   done
   ```
6. In Claude Code, run the `bootstrap-instance` skill
   (`meta-os/skills/bootstrap-instance/SKILL.md`) — a one-time onboarding conversation
   that asks you to choose a backlog/tracking model (none / local JSON / Jira-integrated),
   registers your first project, and optionally wires up its GitHub repo. Or do it by
   hand: copy `templates/project.md` into `projects/<name>.md`, fill it in, add a row to
   `projects/_index.md`.

## What's pre-wired

- `_index.md` / `CLAUDE.md` — instance contract + home MOC, ready to fill in
- `projects/`, `memory/{raw,wiki,output}/`, `automations/`, `vaults/` — the folder
  skeleton with `_index.md` tables of contents, per the framework's conventions
- `automations/_index.md` — a starter table of generic candidate automations (including
  the `meta-os-dashboard` heartbeat) — prune or extend to taste
- Framework mounts (`skills/`, `systems/`, `templates/`, `agents/`) as symlinks to a
  sibling `meta-os` checkout

## Optional: the dashboard

[meta-os-dashboard](https://github.com/mova77/meta-os-dashboard) is a layer-3
observability app that reads this instance's markdown/JSON straight off disk — sprint
lanes, a live knowledge graph, the memory promotion pipeline, ontology linting, and more.
Point its `instance.config.json` at this repo's path once you have real data flowing.

## Learn the model

Read `meta-os/CLAUDE.md` and `meta-os/systems/_index.md` for the full operating model —
this template only gets you to a blank, correctly-wired vault; the framework repo
explains *how* to use it.
