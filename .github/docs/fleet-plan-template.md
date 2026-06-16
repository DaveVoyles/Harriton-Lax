# Fleet plan template

Use this template when you receive a new user request that needs a resumable execution plan.

## Current status

🟢 **Wave N: [Status]** ([X]/[Y] lanes active)

| Agent | Lane | Current work | Status | Blocker / next step |
| ----- | ---- | ------------ | ------ | ------------------- |
| [Fleet Name] | LANE-001 | [Current task] | [Running / complete / blocked] | [Checkpoint, blocker, or next action] |
| [Fleet Name] | LANE-002 | [Current task] | [Running / complete / blocked] | [Checkpoint, blocker, or next action] |

🟡 **Wave N+1: Pending** (waiting on Wave N synthesis)

**Last update:** [Time]
**Next checkpoint:** [Time]

---

## Request

- **User request:**
- **Target outcome:**
- **Risk level:** Low | Medium | High
- **Plan status:** Planned | In progress | Blocked | Complete

## Requirements, assumptions, and risks

Use deterministic IDs for Medium or High risk work. Low risk solo work may mark this section `N/A` with a reason.

### Requirements

| ID | Requirement | Acceptance criteria | Source |
| -- | ----------- | ------------------- | ------ |
| REQ-001 | [User-visible requirement] | [How completion is proven] | [User request / issue / doc] |

### Assumptions

| ID | Assumption | Validation or expiry condition | Status |
| -- | ---------- | ------------------------------ | ------ |
| ASM-001 | [Assumption made to proceed] | [How to confirm or supersede] | Open |

### Risks

| ID | Risk | Likelihood | Impact | Mitigation |
| -- | ---- | ---------- | ------ | ---------- |
| RISK-001 | [Failure mode] | Low / Medium / High | Low / Medium / High | [Concrete mitigation] |

## Context map

- **Primary files:** [Files or folders lanes must inspect or modify]
- **Secondary files:** [Adjacent docs, configs, tests, scripts, or references]
- **Tests and validation:** [Commands, manual checks, or review gates already available]
- **Patterns to follow:** [Existing implementation, docs, naming, or workflow patterns]
- **Change sequence:** [Order of safe edits, validation, synthesis, and handoff]

## Review scope tracking

| Review mode | Required? | Owner or lane | Scope | Status |
| ----------- | --------- | ------------- | ----- | ------ |
| Plan review | Yes / No  | [Role/lane]   | [Planning assumptions and decomposition] | Not started |
| Task review | Yes / No  | [Role/lane]   | [Lane-level task output] | Not started |
| Wave review | Yes / No  | [Role/lane]   | [Integrated wave output] | Not started |
| Final review | Yes / No | [Role/lane]   | [Complete deliverable and user request fit] | Not started |
| Governance review | Yes / No | [Role/lane] | [Authority, side effects, trust boundaries] | Not started |
| QA sign-off | Yes / No | [Role/lane] | [Behavior checks and bug reports] | Not started |

## Waves

### Wave 1

| Lane | Fleet name | Effort | Scope | Blocked by | Status      | Checkpoint |
| ---- | ---------- | ------ | ----- | ---------- | ----------- | ---------- |
| LANE-001 | Han 😉🚀   | M      |       | —          | Not started |            |

### Wave 2

| Lane | Fleet name | Effort | Scope | Blocked by | Status      | Checkpoint |
| ---- | ---------- | ------ | ----- | ---------- | ----------- | ---------- |
| LANE-002 | Yoda 👽✨  | S      |       | —          | Not started |            |

Add or remove waves as needed. Keep the lanes within a wave close in size. Mark dependencies in "Blocked by" column.

## Lane contracts

Use this table when one lane depends on another lane's output.

| Provider lane | Consumer lane | Deliverable | Ready signal | Contract or constraint | Deadline |
| ------------- | ------------- | ----------- | ------------ | ---------------------- | -------- |
| [Lane/Fleet]  | [Lane/Fleet]  | [Artifact, decision, or interface] | [How the consumer knows it is ready] | [Shape, compatibility, or sequencing requirement] | [Time/checkpoint] |

## Specialist lane routing

Use role or lane wording instead of tool-specific names.

| Trigger | Route to | Done-when |
| ------- | -------- | --------- |
| UI, interaction, visual layout, or accessibility concern | UI specialist lane | UI behavior is reviewed and accessibility risks are logged or resolved. |
| Authentication, authorization, secrets, injection, or data exposure concern | Security specialist lane | Security impact is reviewed and blocking findings are resolved before synthesis. |
| Latency, scale, resource use, or hot-path concern | Performance specialist lane | Performance assumptions are validated or tracked with clear follow-up. |
| Browser workflow, end-to-end interaction, or user journey concern | Browser-flow specialist lane | Critical browser path is checked or documented with a reproducible validation gap. |
| Bug fix, regression, or unclear root cause | Bug-fix specialist lane | Root cause, fix scope, and regression check are documented. |

## Wave 1 communication log

| Time | Lane | Fleet Name | Update |
| ---- | ---- | ---------- | ------ |
| —    | —    | —          | —      |

**Checkpoint windows:** S=5m, M=10m, L=15m. Escalate if silent beyond window.

## Duck review lane

- **Assigned duck:** [Fleet Name / agent type / N/A]
- **Required?** Yes | No — [reason]
- **Scope:** plan critique | idea ducking | completion review
- **Authority:** Advisory only; does not edit files or override orchestrator decisions.

## Duck consultation log

| Time | Lane | Reviewer | Verdict | Findings disposition |
| ---- | ---- | -------- | ------- | -------------------- |
| —    | —    | —        | —       | —                    |

### Duck review checklist

- [ ] Required pre-wave duck review complete or marked N/A with reason.
- [ ] Required lane completion reviews complete or marked N/A with reason.
- [ ] Blocking duck findings resolved before synthesis.
- [ ] Warnings accepted, deferred, or rejected with rationale.
- [ ] Suggestions copied into next-wave improvements when accepted.

## Wave 2 communication log

| Time | Lane | Fleet Name | Update |
| ---- | ---- | ---------- | ------ |
| —    | —    | —          | —      |

## Validation

- **Planned checks:**
- **Completed checks:**
- **Open risks:**
- **Governance review status:** Required review complete or marked N/A with reason
- **QA sign-off status:** Required sign-off complete or marked N/A with reason
- **Prompt-validation status:** Required validation complete or marked N/A with reason
- **Duck review status:** Required reviews complete; blocking findings resolved; warnings/suggestions dispositioned
- **Lane checkpoint compliance:** All agents hit update windows and logged transitions
- **Hard stops:** No lanes exceeded hard stop times (or documented overages)
- **Rebalancing:** Lane pace divergence detected and rebalanced (or noted why not)

### Validation matrix

| ID | Check type | Planned check | Owner or lane | Completed? | Evidence or notes |
| -- | ---------- | ------------- | ------------- | ---------- | ----------------- |
| VAL-001 | Happy path | [Expected successful workflow] | [Role/lane] | No | [Command, review, or manual result] |
| VAL-002 | Boundary | [Limit, empty, edge, or compatibility case] | [Role/lane] | No | [Command, review, or manual result] |
| VAL-003 | Negative/error | [Failure, invalid input, or recovery case] | [Role/lane] | No | [Command, review, or manual result] |
| VAL-004 | Concurrency/idempotency | [Retry, parallel, repeated-run, or race case] | [Role/lane] | No | [Command, review, or manual result] |
| VAL-005 | Specialist checks | [UI, security, performance, browser-flow, or bug-fix check] | [Role/lane] | No | [Command, review, or manual result] |

### Evidence ledger

Use when the plan relies on external documentation, package behavior, platform limits, benchmark numbers, security or compliance claims, compatibility claims, or manual verification.

| Evidence ID | Supports | Source or command | Owner | Result | Limits |
| ----------- | -------- | ----------------- | ----- | ------ | ------ |
| VAL-001 or EVD-001 | REQ-001 | [Command, file, URL, or review note] | [Lane] | pass/fail/unknown | [What this does not prove] |

### QA sign-off

| Check area | Owner or lane | Status | Evidence or bug report |
| ---------- | ------------- | ------ | ---------------------- |
| Happy path | [Lane] | Not started | [Evidence ID or notes] |
| Error states | [Lane] | Not started | [Evidence ID or notes] |
| Edge cases | [Lane] | Not started | [Evidence ID or notes] |
| Accessibility basics | [Lane] | Not started | [Evidence ID or notes] |
| Performance symptoms | [Lane] | Not started | [Evidence ID or notes] |

### PR-comment and review-response disposition

Use when responding to PR comments, `code-review` findings, or Rubber Duck blocking feedback.

| Comment or finding ID | Disposition | Files changed or rationale | Validation |
| --------------------- | ----------- | -------------------------- | ---------- |
| COMMENT-001 | fixed / rejected / blocked / deferred | [Files or rationale] | [Evidence ID or N/A] |

### Governance review

| Check | Status | Notes |
| ----- | ------ | ----- |
| Lane trust boundaries are explicit | Not started | |
| Allowed and disallowed side effects are documented | Not started | |
| Ambiguous high-impact actions fail closed | Not started | |
| Required human approval gates are preserved | Not started | |
| Audit notes for overrides and skipped gates are append-only | Not started | |

### ADR trigger

- **ADR required?** Yes | No — [reason]
- **ADR ID or file:** ADR-001 / N/A
- **Decision affected:** [architecture, module boundary, API, data model, deployment, testing, toolchain, or agent/process authority]
- **Linked IDs:** [REQ-###, RISK-###, LANE-###]

### Prompt-validation checklist

Use when changing shared instructions, skills, reusable prompts, or agent-facing docs.

- [ ] Role boundaries are clear and do not conflict with existing instructions.
- [ ] Tool names and agent types are supported by the current runtime.
- [ ] Required output formats are deterministic enough for another agent to follow.
- [ ] Approval gates, secret handling, and dirty-worktree rules remain intact.
- [ ] Failure and blocked states are explicit.
- [ ] At least one representative scenario was checked against the revised instruction.

### Quality Playbook escalation

- **Required?** Yes | No — [reason]
- **Trigger:** release-critical | security-sensitive | migration-heavy | defect-heavy | repeated validation failure | N/A
- **Escalation phases:** explore | generate validation | review | audit | reconcile | verify
- **Outcome:** [not started / complete / deferred with reason]

### Optional simplification pass

- **Required?** Yes | No — [reason]
- **Owner or lane:** [Role/lane]
- **Simpler alternative considered:** [What can be removed, combined, or deferred]
- **Outcome:** Accepted | Rejected | Deferred — [rationale]

### Markdown accessibility checklist

- [ ] Headings use a logical hierarchy and sentence case.
- [ ] Tables have clear headers and concise cell content.
- [ ] Link text is descriptive without relying on surrounding prose.
- [ ] Emojis are decorative or paired with text labels.
- [ ] Checklists and status markers have text equivalents.

## Synthesis phase

- **Starts when:** All lanes report ✅ `Deliverable complete`
- **Deadline:** 5 minutes after last lane completes (hard deadline)
- **Orchestrator:** Owns final conflict resolution; do not re-open lane disputes
- **Synthesis begins:** [Time lanes all completed]
- **Synthesis deadline:** [Time + 5 min]
- **Duck findings:** [blocking resolved / warnings tracked / suggestions deferred]

## Final user recap

Use this table-driven dashboard for multi-agent or multi-wave completion summaries.

### Outcome

[1-2 sentences: what is now true, where it landed, and whether anything is blocked.]

### Work completed

| Area | What changed | Status |
| ---- | ------------ | ------ |
| [Area] | [Outcome] | ✅ Complete |

### Agent contributions

| Agent | Lane | Delivered | Result |
| ----- | ---- | --------- | ------ |
| [Fleet Name] | LANE-001 | [Deliverable] | ✅ Passed |

### Validation

| Check | Evidence | Result |
| ----- | -------- | ------ |
| [Check] | [Command, review, or artifact] | ✅ Passed |

### Decisions

| Decision | Rationale |
| -------- | --------- |
| [Decision] | [Why this was chosen] |

### Blockers / deferred

| Item | Status | Next step |
| ---- | ------ | --------- |
| _(none)_ | N/A | N/A |

### Next action

[Only include a user action when one is required; otherwise say `None`.]

## Wave retrospective

### Actual vs. Estimated

- Lane 1: Estimated —, took — → [on target|over|early]
- Lane 2: Estimated —, took — → [on target|over|early]

### Critical path analysis

- Blocker chain: [Lane X → Lane Y → ...]
- Impact: [synthesis delay, idle time, or no impact]

### What went well

- [Item 1]
- [Item 2]

### What to improve for next wave

- [Item 1]
- [Item 2]

### Duck findings

- **Blocking:** [Resolved items or none]
- **Warnings:** [Accepted/deferred/rejected with rationale]
- **Suggestions:** [Candidate next-wave improvements]

### Required next-wave improvements (prioritized)

| Priority | Improvement               | Owner        | Effort  | Score                                | Done-when             |
| -------- | ------------------------- | ------------ | ------- | ------------------------------------ | --------------------- |
| P0       | [Critical blocker fix]    | [Lane/Fleet] | [S/M/L] | [(Impact x Urgency) - Effort - Risk] | [Acceptance criteria] |
| P1       | [High-impact improvement] | [Lane/Fleet] | [S/M/L] | [(Impact x Urgency) - Effort - Risk] | [Acceptance criteria] |
| P2       | [Optional enhancement]    | [Lane/Fleet] | [S/M/L] | [(Impact x Urgency) - Effort - Risk] | [Acceptance criteria] |

### Decision log

- ✅ [Approved decision]
- ⚠️ [Escalated blocker]
- 🔴 [Action for next wave]

## Handoffs

### Handoff note

- **Lane:**
- **Current scope:**
- **Files inspected or touched:**
- **Progress so far:**
- **Blocker:**
- **Exact next step:**

### Onboarding artifact trigger

- **Required?** Yes | No — [reason]
- **Artifact type:** docs section | architecture map | code-tour outline | runbook update | handoff note | N/A
- **Owner:** [Role/lane]
- **Location:** [Path or N/A]

## Plan completion checklist

- [ ] Update this plan when a wave begins.
- [ ] Update this plan when a lane changes owner.
- [ ] Update this plan when a lane stalls or resumes.
- [ ] Update this plan before final synthesis.
- [ ] Evaluate governance, QA, evidence, ADR, prompt-validation, review-response, and onboarding triggers.

---

**Version:** 5.23
**Last Updated:** May 19, 2026
