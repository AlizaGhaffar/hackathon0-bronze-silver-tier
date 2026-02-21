---
description: Process files from Needs_Action/ — classify, plan, and advance through the pipeline.
---

## User Input

```text
$ARGUMENTS
```

You **MUST** consider the user input before proceeding (if not empty). If the user names a specific file, process only that file. Otherwise, process all pending items.

---

## Skill: Triage & Plan

You are the AI Employee's triage agent. Your job is to read items in `Needs_Action/`, classify them, create an actionable plan in `Plans/`, and advance the item through the pipeline.

### Step 1 — Scan Needs_Action/

1. List all `.md` files in `Needs_Action/` that have `status: pending` in their YAML front matter.
2. If no pending items exist, report "No pending items in Needs_Action/" and stop.
3. Display what you found:

```
Found N pending item(s) in Needs_Action/:
  - FILE_expense_report.md (P3, file_drop)
  - FILE_meeting_notes.md (P2, file_drop)
```

### Step 2 — Read & Classify Each Item

For each pending `.md` file:

1. Read the `.md` metadata file.
2. If there is a companion data file (same name without `.md` extension), read that too to understand the actual content.
3. Classify the task type based on content:

| Type            | Indicators                                           |
|-----------------|------------------------------------------------------|
| `linkedin_post` | Filename starts with `LINKEDIN_`, or contains sales/lead-gen language for LinkedIn |
| `email`         | Contains email addresses, "Subject:", "From:", "Re:"  |
| `task`          | Contains action verbs, deadlines, assignments         |
| `receipt`       | Contains amounts, payment, invoice, receipt           |
| `note`          | General text, meeting notes, brainstorming            |
| `document`      | Reports, proposals, formal documents                  |
| `unknown`       | Cannot determine — flag for human review             |

4. Assess priority using the rules from `Company_Handbook.md`:
   - **P1 keywords**: urgent, ASAP, overdue, security, payment failed
   - **P2 keywords**: deadline, meeting, invoice, review, approval
   - **P3**: Everything else (default)

### Step 3 — Create Plan in Plans/

For each classified item, create a plan file at `Plans/PLAN_<original-stem>.md`:

```markdown
---
source: Needs_Action/FILE_<name>.md
type: <classified type>
priority: <P1|P2|P3>
status: planned
created: <YYYY-MM-DD HH:MM:SS>
---

# Plan: <descriptive title>

## Summary
<2-3 sentence summary of what this item is and what needs to happen>

## Classification
- **Type:** <type>
- **Priority:** <priority>
- **Requires Approval:** <yes/no — yes if P1, involves money, or external communication>

## Action Steps
- [ ] Step 1: <specific action>
- [ ] Step 2: <specific action>
- [ ] Step 3: <specific action>

## Approval Required
<If requires_approval is yes, explain what needs human sign-off>
<If no, state "No approval needed — can proceed autonomously">

## Source Files
- Metadata: `Needs_Action/FILE_<name>.md`
- Data: `Needs_Action/FILE_<name>.<ext>` (if exists)
```

**Plan action steps must be concrete and executable.** Examples by type:

- **linkedin_post**: Draft a LinkedIn post using format below, save plan as `Plans/PLAN_linkedin_post_<YYYY-MM-DD>.md`, create approval file in `Pending_Approval/`, log to `Logs/linkedin.log`
- **email**: Draft reply, identify recipients, flag for send approval
- **task**: Break into subtasks, identify dependencies, estimate effort
- **receipt**: Extract amount, categorize expense, log to tracking
- **note**: Summarize key points, extract action items, archive
- **document**: Summarize, extract decisions, identify follow-ups

#### Special handling: `linkedin_post`

When an item is classified as `linkedin_post`:

1. **Plan filename**: Use `Plans/PLAN_linkedin_post_<YYYY-MM-DD>.md` (not the original stem)
2. **Draft the post** inside the plan using this format:
   ```
   Excited to offer [service extracted from message] for [benefit extracted from message]! DM for more.
   ```
3. **Create an approval file** at `Pending_Approval/APPROVE_linkedin_post_<YYYY-MM-DD>.md` with:
   ```markdown
   ---
   source_plan: Plans/PLAN_linkedin_post_<YYYY-MM-DD>.md
   type: linkedin_post
   status: pending_approval
   created: <YYYY-MM-DD HH:MM:SS>
   ---
   # LinkedIn Post — Awaiting Approval
   <the drafted post text>
   ```
4. **Log** to `Logs/linkedin.log` (not the standard triage log):
   ```
   [<timestamp>] DRAFTED: linkedin_post | source=<filename> | plan=PLAN_linkedin_post_<YYYY-MM-DD>.md | approval=Pending_Approval/APPROVE_linkedin_post_<YYYY-MM-DD>.md
   ```
5. **Requires Approval**: Always `yes` — external public communication

### Step 4 — Update Item Status

Update the original `.md` file in `Needs_Action/`:

1. Change `status: pending` to `status: in_progress`
2. Add `plan: Plans/PLAN_<name>.md` to the YAML front matter
3. Add `classified_type: <type>` to the YAML front matter
4. Add `triaged_at: <YYYY-MM-DD HH:MM:SS>` to the YAML front matter

### Step 5 — Log the Action

Append to `Logs/<YYYY-MM-DD>_triage.log`:

```
[<timestamp>] TRIAGED: FILE_<name>.md | type=<type> | priority=<priority> | plan=PLAN_<name>.md
```

Create the log file if it doesn't exist.

### Step 6 — Report

After processing all items, display a summary table:

```
## Triage Complete

| Item | Type | Priority | Plan | Approval? |
|------|------|----------|------|-----------|
| FILE_expense_report.md | receipt | P3 | PLAN_expense_report.md | No |
| FILE_meeting_notes.md  | note   | P2 | PLAN_meeting_notes.md  | No |

Next steps:
- Review plans in Plans/ folder
- Run `/approve <plan>` to approve and execute
- Items requiring approval are in Pending_Approval/
```

If any items were classified as `unknown` or priority `P1`, flag them:

```
!! ATTENTION: 1 item needs human review (unknown type)
!! ATTENTION: 1 item is P1 priority — review immediately
```

---

### Rules

- **Never delete files** — only move or update status
- **Never execute plans** — this skill only triages and creates plans
- **P1 items**: Always set `requires_approval: true`
- **Money-related items**: Always set `requires_approval: true`
- **Unknown type**: Route to `Pending_Approval/` instead of creating a plan
- Read `Company_Handbook.md` if you need to verify approval thresholds or priority rules
