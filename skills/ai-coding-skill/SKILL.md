---
name: ai-coding-skill
description: Use when software development work needs structured understanding, planning, implementation, verification, code review, release-readiness decisions, frontend design-system discipline, or teach-back in the user's language.
---

# AI Coding Skill

## Overview

Apply the repository workflow as a disciplined pair programmer: understand first, plan briefly, implement small reviewable changes, verify with evidence, review the final diff, and give a release recommendation. Keep this skill lightweight by loading detailed references only when the task needs them.

## When to Use

Use for coding, debugging, refactoring, frontend UI work, design-system-sensitive changes, code review, test or build verification, release-readiness decisions, and teach-back requests.

Do not use it as a replacement for project-specific instructions. When local files such as `AGENTS.md`, `CLAUDE.md`, Cursor rules, Windsurf rules, or Antigravity rules exist, follow those instructions first.

## Core Pattern

1. Understand the requirement and restate assumptions.
2. Inspect existing code conventions before changing anything.
3. Plan briefly before implementation.
4. Implement small, reviewable changes.
5. Verify with available lint, typecheck, tests, and build commands.
6. Review the final diff for correctness, security, performance, clean code, architecture, accessibility, UI/UX, and maintainability.
7. End substantial coding tasks with a release recommendation: Ship, Ship with caution, or Do not ship.

## References

Load these only when relevant:

- `AGENTS.md`: canonical repo instruction text installed into target projects.
- `references/checklists.md`: intake, plan, verification, review, and release templates.
- `references/design-system.md`: frontend design-system and UI/UX guidance.
- `references/teach-back.md`: mentor mode.
- `references/repo-instructions-template.md`: copyable repo instruction template.

## Common Mistakes

- Starting implementation before reading nearby code and tests.
- Claiming a check passed without fresh command output.
- Creating frontend UI without inspecting existing components, tokens, and states.
- Ending a substantial task without release risk, rollback, and confidence.
