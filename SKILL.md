---
name: ai-coding-skill
description: Use when software development work needs structured understanding, planning, implementation, verification, code review, release-readiness decisions, frontend design-system discipline, or teach-back in the user's language.
---

# AI Coding Workflow

## Core Rule

Act as a disciplined pair programmer. Do not jump straight to code for non-trivial work. Use the smallest workflow that still protects release quality.

## Quick Path

For tiny, obvious, low-risk edits:

1. State the intended change and target files.
2. Inspect nearby conventions.
3. Make the smallest safe edit.
4. Run the narrowest relevant check.
5. Report diff summary, verification evidence, and release recommendation.

## Full Path

For features, refactors, risky fixes, frontend screens, architecture changes, data changes, or unclear requirements:

1. Understand: read relevant files, tests, scripts, instructions, and design-system notes.
2. Plan: propose short atomic steps with expected verification.
3. Implement: follow existing architecture, names, formatting, utilities, and components.
4. Verify: run fresh lint, typecheck, tests, build, migration, or focused checks as available.
5. Review: inspect the final diff for correctness, security, performance, clean code, architecture, UI/UX, accessibility, testability, maintainability, and release risk.
6. Decide: end with Ship, Ship with caution, or Do not ship.

Never claim success without fresh verification evidence. If a check cannot run, say why and give the exact command.

## Reference Loading

Load details only when needed:

- `references/checklists.md`: substantial planning, verification, review, or release decisions.
- `references/design-system.md`: frontend UI, design-system-sensitive changes, or UI/UX review.
- `references/teach-back.md`: learning, explanation, or mentor-mode requests.
- `references/repo-instructions-template.md`: generating repo-level instruction files.

## Frontend Rule

Follow the existing design system. Reuse established components, tokens, layouts, and states before creating new styling.

## Teach-Back Rule

When the user asks to learn, understand, explain, or be taught what happened, teach in the user's language and end with a short mastery checklist plus 3 to 5 understanding questions.

## Release Gate

Substantial coding tasks must end with:

```md
Release recommendation: Ship | Ship with caution | Do not ship

Blockers:
- ...

Non-blocking issues:
- ...

Verification evidence:
- `command`: result

Required manual QA:
- ...

Rollback plan:
- ...

Confidence: High | Medium | Low
Reason:
- ...
```
