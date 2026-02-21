# Personal AI Employee — Hackathon 0

> **Tier Status: Bronze ✅ + Silver ✅ — Both Completed**

*Your life and business on autopilot. Local-first, agent-driven, human-in-the-loop.*

Built for **Hackathon 0: Building Autonomous FTEs in 2026** by [Panaversity](https://www.panaversity.org/).

---

## What This Is

A fully functional **Personal AI Employee** — an autonomous agent that monitors your Gmail, manages your business pipeline, auto-posts on LinkedIn to generate leads, and handles the full triage-to-action workflow, all with a human-in-the-loop safety layer.

The agent runs locally, uses **Claude Code** as its reasoning engine, **Obsidian** as its dashboard and memory, and custom **Python Watchers + MCP servers** as its eyes and hands.

---

## Tier Achievements

### Bronze Tier ✅ — Foundation (Completed)

| Requirement | Status |
|---|---|
| Obsidian vault with `Dashboard.md` and `Company_Handbook.md` | ✅ Done |
| Working Watcher script (Gmail + File System) | ✅ Done |
| Claude Code reading from and writing to the vault | ✅ Done |
| Basic folder structure: `/Inbox`, `/Needs_Action`, `/Done` | ✅ Done |
| AI functionality implemented as Agent Skills | ✅ Done |

### Silver Tier ✅ — Functional Assistant (Completed)

| Requirement | Status |
|---|---|
| All Bronze requirements | ✅ Done |
| Multiple Watcher scripts (Gmail + LinkedIn + File System) | ✅ Done |
| Automated LinkedIn posting to generate business leads | ✅ Done |
| Claude reasoning loop that creates `Plan.md` files | ✅ Done |
| Working MCP server for external actions (email sending via Gmail API) | ✅ Done |
| Human-in-the-loop approval workflow for sensitive actions | ✅ Done |
| Scheduling via Windows Task Scheduler | ✅ Done |
| All AI functionality implemented as Agent Skills | ✅ Done |

---

## Architecture

```
┌─────────────────────────────────────────────────────┐
│                 EXTERNAL SOURCES                     │
│      Gmail          LinkedIn         File System     │
└──────────┬─────────────┬────────────────┬────────────┘
           │             │                │
           ▼             ▼                ▼
┌─────────────────────────────────────────────────────┐
│                  PERCEPTION LAYER                    │
│   gmail_watcher.py  │  linkedin_watcher.py           │
│   file_watcher.py   │  base_watcher.py               │
└──────────────────────────┬──────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────┐
│              OBSIDIAN VAULT (Local Memory)           │
│  Inbox → Needs_Action → Plans → Pending_Approval     │
│                               → Approved → Done      │
│                               → Rejected             │
│  Dashboard.md  │  Company_Handbook.md  │  Logs/      │
└──────────────────────────┬──────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────┐
│                  REASONING LAYER                     │
│               CLAUDE CODE (Agent)                    │
│    Read → Triage → Plan → Request Approval → Act     │
└──────────────────────────┬──────────────────────────┘
                           │
              ┌────────────┴────────────┐
              ▼                         ▼
┌─────────────────────┐    ┌───────────────────────────┐
│  HUMAN-IN-THE-LOOP  │    │       ACTION LAYER         │
│  Review → Approve/  │───▶│  MCP Server (Email/Gmail)  │
│  Reject in vault    │    │  LinkedIn Auto-Post Skill  │
└─────────────────────┘    └───────────────────────────┘
```

---

## Tech Stack

| Component | Technology | Purpose |
|---|---|---|
| Reasoning Engine | Claude Code (claude-sonnet-4-6) | Core AI logic |
| Dashboard & Memory | Obsidian (local Markdown vault) | GUI + persistent state |
| Gmail Watcher | Python + Gmail API (OAuth2) | Monitor incoming emails |
| LinkedIn Watcher | Python + Playwright | Monitor + auto-post |
| File Watcher | Python + watchdog | Monitor file drops |
| Email MCP Server | Python MCP + Gmail API | Send emails as action |
| Scheduler | Windows Task Scheduler | Trigger watchers on boot |
| Spec-Driven Dev | Claude Code + SDD (SpecKit) | Architecture & planning |

---

## Project Structure

```
hack0aliza/
├── Dashboard.md              # Nerve center — live status view
├── Company_Handbook.md       # AI employee rules of engagement
├── Hackathon_Guide.md        # Full hackathon reference
├── Inbox/                    # Raw incoming items from watchers
├── Needs_Action/             # Triaged items awaiting Claude
├── Plans/                    # Claude-generated execution plans
├── Pending_Approval/         # Awaiting human review
├── Approved/                 # Human-approved → AI executes
├── Rejected/                 # Rejected with feedback
├── Done/                     # Completed work archive
├── Logs/                     # Timestamped audit trail
├── Memory/                   # Persistent AI memory
│   ├── conversation_log.md
│   ├── preferences.md
│   └── linkedin_posts.md
├── Watchers/                 # Monitoring scripts
│   ├── base_watcher.py
│   ├── gmail_watcher.py
│   ├── linkedin_watcher.py
│   └── file_watcher.py
├── mcp_servers/              # MCP action servers
│   ├── email_server.py       # Send emails via Gmail API
│   └── gmail_auth.py
├── Skills/                   # Claude Agent Skills
│   ├── triage.md
│   ├── approve.md
│   ├── draft-reply.md
│   ├── summarize.md
│   └── linkedin-watcher.md
├── .claude/
│   ├── mcp.json              # MCP server config
│   └── commands/             # Slash command definitions
│       ├── triage.md
│       └── approve.md
└── .specify/                 # Spec-Driven Development artifacts
    ├── memory/constitution.md
    └── templates/
```

---

## Key Features Built

### 1. Email Triage Pipeline
Incoming Gmail messages are automatically fetched by `gmail_watcher.py`, saved to `Needs_Action/`, triaged by Claude, planned in `Plans/`, and queued for approval before any reply is sent.

### 2. LinkedIn Auto-Posting
`linkedin_watcher.py` (Playwright-based) monitors LinkedIn and the LinkedIn Poster Agent Skill drafts and posts business updates to generate leads — fully implemented and demonstrated in `Done/`.

### 3. MCP Email Server
`mcp_servers/email_server.py` is a live MCP server that Claude calls to send emails via the Gmail API after human approval — no direct send without sign-off.

### 4. Human-in-the-Loop (HITL) Approval
Every sensitive action (sending emails, posting, etc.) creates an approval file in `Pending_Approval/`. The AI does not act until the file is moved to `Approved/`. Rejected items are filed in `Rejected/` with feedback.

### 5. Agent Skills
All AI functionality is packaged as reusable Claude Agent Skills (`/triage`, `/approve`, `/draft-reply`, `/summarize`) following the hackathon requirement.

### 6. Audit Logging
Every pipeline transition is logged with timestamp in `Logs/` for full traceability.

---

## Setup

### Prerequisites

- Claude Code (Pro subscription or API key)
- Python 3.13+
- Node.js v24+ LTS
- Obsidian v1.10.6+
- Google Cloud project with Gmail API enabled

### Installation

```bash
# Clone the repo
git clone https://github.com/AlizaGhaffar/hackathon0-bronze-silver-tier.git
cd hackathon0-bronze-silver-tier

# Install Python dependencies
pip install google-auth google-auth-oauthlib google-api-python-client playwright watchdog

# Install Playwright browser
playwright install chromium

# Set up Gmail OAuth credentials
# Place your client_secret_*.json in the root (gitignored)
python mcp_servers/gmail_auth.py
```

### Environment Variables

Create a `.env` file (never commit this):

```env
GMAIL_CLIENT_ID=your_client_id
GMAIL_CLIENT_SECRET=your_client_secret
```

### Running the Watchers

```bash
# Gmail watcher (monitors inbox every 2 minutes)
python Watchers/gmail_watcher.py

# File system watcher (monitors Inbox/ folder)
python Watchers/file_watcher.py

# LinkedIn watcher (first run: complete browser login manually)
python Watchers/linkedin_watcher.py
```

### Claude Code Commands

```bash
/triage          # Classify and plan all Needs_Action items
/approve         # Review and execute plans
/triage <file>   # Triage a specific file
```

---

## Pipeline Flow

```
Watcher detects event
        │
        ▼
  Inbox/ (raw item)
        │
        ▼
  Needs_Action/ (AI triages, adds metadata, sets priority)
        │
        ▼
  Plans/ (Claude creates step-by-step plan.md)
        │
        ▼
  Pending_Approval/ (human reviews)
        │
   ┌────┴────┐
   ▼         ▼
Approved/  Rejected/
   │
   ▼
  AI executes via MCP
   │
   ▼
  Done/ (archived with timestamp)
   │
  Logs/ (audit trail written at every stage)
```

---

## Hackathon Submission

- **Tier:** Silver (Bronze + Silver both completed)
- **Hackathon:** Personal AI Employee Hackathon 0 — Panaversity
- **Submit Form:** https://forms.gle/JR9T1SJq5rmQyGkGA

---

## Security Notes

- `.env`, `token.json`, and `client_secret*.json` are gitignored — never committed
- No credentials are stored in Markdown files
- All sensitive actions require human approval before execution
- Audit logs retained in `Logs/` for review
