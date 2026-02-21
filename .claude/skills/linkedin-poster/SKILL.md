---
name: "linkedin poster"
description: "Create engaging LinkedIn posts to promote business, generate sales leads, and share professional updates. Use when user asks to post on LinkedIn, create sales content, or generate business leads."
---

# LinkedIn Poster Skill

## When to Use This Skill

- User asks to "create a LinkedIn post" or "post on LinkedIn"
- User mentions sales, client acquisition, or business promotion
- User needs professional social media content
- Keywords: sales, client, project, business, offer, service

## Procedure

### Step 1 — Gather Context

1. **Scan `Needs_Action/`**: Look for files with keywords (`sales`, `client`, `project`, `promotion`, `offer`, `service`)
2. **Check user input**: If the user provided a topic, service, or target audience, use that directly
3. **Read `Company_Handbook.md`**: Pull tone rules and formatting guidelines
4. **Check `Memory/`**: Look for past LinkedIn posts or business context for consistency

### Step 2 — Extract Service & Benefit

1. **Identify the service**: What is being offered? (consulting, development, product, etc.)
2. **Identify the benefit**: What problem does it solve for the target audience?
3. **Identify the audience**: Who should see this post? (CTOs, startups, agencies, etc.)
4. **Identify the CTA**: What should the reader do? (DM, book a call, visit link, etc.)

### Step 3 — Draft the Post

Generate a LinkedIn post following this structure:

```
[Hook — attention-grabbing first line]

[Problem statement — what pain point does the audience have?]

[Solution — how your service/product solves it]

[Proof/credibility — results, experience, or social proof]

[Call to action — clear next step]

[Hashtags — 3-5 relevant hashtags]
```

**Post Guidelines:**
- **Length**: 150-300 words (LinkedIn sweet spot for engagement)
- **Tone**: Professional but conversational (per Company Handbook)
- **Format**: Use line breaks for readability, emoji sparingly (1-3 max)
- **Hook**: First line must stop the scroll — use a bold claim, question, or stat
- **CTA**: Always end with a clear call to action (DM, comment, link)
- **No filler phrases**: Be direct and value-driven

### Step 4 — Create Plan File

Save the draft to `Plans/PLAN_linkedin_post_<YYYY-MM-DD>.md`:

```markdown
---
source: <Needs_Action file or "manual request">
type: social_media
platform: linkedin
priority: P3
status: planned
requires_approval: true
created: <YYYY-MM-DD HH:MM:SS>
---

# Plan: LinkedIn Post — <topic>

## Summary
<1-2 sentence description of the post and its goal>

## Target Audience
<who this post is for>

## Draft Post

<the full LinkedIn post content>

## Action Steps
- [ ] Review draft for accuracy and tone
- [ ] Approve post content
- [ ] Post to LinkedIn (manual or via automation)
- [ ] Track engagement (likes, comments, DMs)
- [ ] Archive to Done/

## Approval Required
Yes — all external communications require human approval before posting.
```

### Step 5 — Route for Approval

1. **Move plan** to `Pending_Approval/` (all external content requires human sign-off)
2. **Log** the action to `Logs/<YYYY-MM-DD>_linkedin.log`:
   ```
   [<timestamp>] DRAFTED: LinkedIn post — <topic> | status=pending_approval
   ```
3. **Notify user**: Display the draft and ask for approval

### Step 6 — Post-Approval Execution

After human approves:

1. **If LinkedIn MCP/Playwright available**: Auto-post via automation
2. **If no automation**: Copy post text to clipboard, provide instructions to post manually
3. **Log** the posting:
   ```
   [<timestamp>] POSTED: LinkedIn post — <topic> | method=<manual|automated>
   ```
4. **Move** to `Done/` with timestamp prefix
5. **Save** to `Memory/linkedin_posts.md` for future reference and tone consistency

---

## Post Templates

### Sales/Lead Generation
```
[Bold claim about results]

Most [audience] struggle with [problem].

Here's what we do differently:
→ [Benefit 1]
→ [Benefit 2]
→ [Benefit 3]

[Brief proof or result]

DM me "[keyword]" if you want to learn more.

#hashtag1 #hashtag2 #hashtag3
```

### Project Showcase
```
Just shipped: [project name]

[What it does in one line]

The challenge: [problem we solved]
The approach: [how we solved it]
The result: [measurable outcome]

Building something similar? Let's talk.

#hashtag1 #hashtag2 #hashtag3
```

### Thought Leadership
```
[Contrarian or insightful take]

[Expand on the insight — 2-3 short paragraphs]

[What this means for the reader]

Agree or disagree? Drop your take in the comments.

#hashtag1 #hashtag2 #hashtag3
```

---

## Safety Rules

- **NEVER** post to LinkedIn without explicit human approval
- **NEVER** make false claims about results or capabilities
- **NEVER** share confidential client information
- **NEVER** use aggressive sales language or spam tactics
- All posts route through `Pending_Approval/` — no exceptions
- Follow Company Handbook tone rules for external communication (professional, warm)
- Keep posts authentic — no AI-sounding filler or buzzword soup
