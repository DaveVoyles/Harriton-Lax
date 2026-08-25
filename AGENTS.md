# Agent instructions — Harriton-Lax

This is the coaching markdown hub, not the public website.

Cursor Cloud: see [`docs/cursor-cloud.md`](docs/cursor-cloud.md).

<!-- harness-adapter:start -->
# This project uses harness

Read the canonical playbook at `$HARNESS_ROOT/AGENTS.md` (cloned playbook, not a symlink).
Project overrides belong in `docs/project-conventions.md` here — never fork harness AGENTS.md.

Harness version stamped by `harness init`: `0.1.1`

Feed emitter (optional, D11): `.harness/session-feed.sh start|stop` implements fleet `docs/feed-schema.md`. Wire it from your agent's session hook. Dispatched sessions appear on the feed without this file — this adapter is for *local* sessions only.
<!-- harness-adapter:end -->
