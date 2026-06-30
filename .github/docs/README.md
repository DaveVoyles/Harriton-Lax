# Repo-specific docs

This folder is the repo-specific extension point for the shared Copilot bootstrap files.

Use `.github/docs/README.md` as the entrypoint. Keep repo-specific detail here instead of hardcoding it into `.github/copilot-instructions.md`.

## Shared versus repo-specific

Keep these files shared and replaceable from the upstream repo:

- `.github/copilot-instructions.md`
- `.github/agents/autonomous-fleet-agent.md`
- `.github/copilot-contract.json`

Keep these files local to each consumer repo:

- `.github/docs/README.md`
- Additional repo-specific docs linked from this file

## What belongs here

- Coding conventions that only apply to this repo
- Architecture notes and service boundaries
- Workflow details that would make the shared instructions too specific
- Task-specific pointers to additional docs in `.github/docs/`

## Starter template

Use this structure when you create or expand repo-specific docs:

```markdown
# Repo-specific docs

## Coding conventions

Document repo-only coding rules here.

## Architecture notes

Summarize important boundaries, modules, or services here.

## Workflow rules

Capture repo-specific process details here.

## Linked docs

- [Example deeper guide](./example-guide.md)
```

## Update rules

1. Preserve existing repo-specific docs when you replace the shared upstream files.
2. Merge new detail intentionally instead of overwriting local docs wholesale.
3. Add links from this file to any additional docs that agents should read.
4. If this file does not exist in a consumer repo, agents should continue with the shared instructions only.

---

## Modular Copilot Instructions v6.0

The copilot instructions have been refactored into a modular architecture for token efficiency.

### Load Strategy

**Always load:**
- `.github/copilot-instructions.md` (primary instructions, ~5.5K tokens)

**Load on-demand based on task:**
- Error handling/debugging → `.github/specialist-guides/error-handling.md`
- Code review/refactoring → `.github/specialist-guides/code-quality.md`
- Architecture decisions → `.github/specialist-guides/architecture-decisions.md`
- Domain-specific work → `.github/specialist-guides/checklists.md`
- User questions → `.github/specialist-guides/user-engagement-model.md`

See `.github/specialist-guides-index.md` for quick decision tree and token cost breakdown.
