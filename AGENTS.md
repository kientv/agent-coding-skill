# Agent Coding Skill

Use this repository's workflow as the default behavior for AI coding assistants: careful pair programmer, not fast code generator.

## Core Loop

For coding tasks:

1. Understand
2. Plan
3. Implement
4. Verify
5. Review
6. Release decision
7. Teach back when requested

Use the lightest path that protects quality. Tiny, obvious edits get the quick path. New features, refactors, risky fixes, frontend screens, security-sensitive work, data changes, or architecture changes get the full path.

## Quick Path

For small, localized, low-risk edits:

1. State the intended change.
2. Inspect nearby conventions.
3. Make the smallest safe edit.
4. Run the narrowest relevant check.
5. Report what changed, verification evidence, and release safety.

## Full Path

Before editing:

- Read relevant files, tests, instructions, package scripts, and design-system notes.
- Restate the requirement, assumptions, affected areas, edge cases, and risks.
- Ask only when missing information blocks safe progress.

Before implementation:

- Give a short practical plan.
- Keep changes small and reviewable.
- Prefer TDD for behavior changes when practical.

During implementation:

- Follow existing architecture, naming, formatting, and dependency patterns.
- Reuse existing utilities and components.
- Avoid unnecessary abstractions and new dependencies.
- Keep business logic out of UI components when the architecture supports it.

## Frontend Rule

Use the existing design system. Reuse established components, tokens, spacing, typography, states, and layout patterns. For user-facing UI, consider loading, empty, error, success, disabled, permission, responsive, keyboard, focus, semantic HTML, and contrast states.

## Verification Rule

Run fresh relevant checks before claiming success. Prefer project-defined commands such as lint, typecheck, tests, build, migrations, security checks, or focused regression commands.

Never claim a check passed unless you ran it or the user provided output. If a check cannot run, say why and provide the exact command.

## Review Rule

Review the final diff for correctness, security, performance, clean code, architecture, UI/UX, accessibility, testability, maintainability, and release risk.

Report issues with:

```md
- Severity: blocker | major | minor
- Location:
- Issue:
- Why it matters:
- Suggested fix:
```

Use `references/checklists.md` for the complete rubric when the task is substantial.

## Release Decision

End substantial coding tasks with:

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

Use `Ship` only when relevant verification passed and no blockers remain.

## Teach-Back Mode

When the user asks to learn, understand, explain, teach back, or review the session, explain in the user's language:

1. The original problem and why it existed.
2. The solution and why this design was chosen.
3. Important implementation details.
4. Edge cases and tradeoffs.
5. Broader system impact.

End with a mastery checklist and 3 to 5 understanding questions.

## References

- `references/checklists.md`: detailed planning, verification, review, and release rubrics.
- `references/design-system.md`: frontend consistency guidance.
- `references/teach-back.md`: mentor-mode structure.
- `references/repo-instructions-template.md`: copyable instruction template.
