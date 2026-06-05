# AI Coding Workflow Checklists

Use these templates when the task needs structure, review, or release gating.

## Intake template

```markdown
## Understanding

Requirement:
- ...

Assumptions:
- ...

Affected files/modules:
- ...

Edge cases:
- ...

Risks:
- security: ...
- performance: ...
- ux: ...
- data or migration: ...
- compatibility: ...
```

## Implementation plan template

```markdown
## Plan

1. Inspect existing pattern in `path/...`.
2. Add or update tests for `behavior`.
3. Implement the smallest change in `path/...`.
4. Update UI states or docs if needed.
5. Run verification: `command`.
6. Review final diff and produce release decision.
```

For complex work, make tasks atomic:

```markdown
### Task N: [name]
Files:
- Create: `path/...`
- Modify: `path/...`
- Test: `path/...`

Acceptance criteria:
- [ ] behavior is observable and testable
- [ ] edge case is covered
- [ ] verification command passes

Verification:
- Command: `...`
- Expected: `...`
```

## Verification command discovery

Prefer project-defined commands over generic guesses. Inspect files such as:

- `package.json`
- `pnpm-workspace.yaml`, `turbo.json`, `nx.json`
- `pyproject.toml`, `tox.ini`, `pytest.ini`
- `Makefile`
- `.github/workflows/*`
- `README.md`, `CONTRIBUTING.md`, `AGENTS.md`, `CLAUDE.md`

Report verification like this:

```markdown
## Verification evidence

- `npm run typecheck`: passed
- `npm test -- path/to/test`: failed, 1 failing test in ...
- `npm run build`: not run because ...
```

Never convert an unrun command into a success claim.

## Diff review rubric

Review changed files only, unless the task explicitly asks for broader audit.

### Correctness

- Requirement is actually implemented.
- Acceptance criteria are covered.
- Edge cases and error paths are handled.
- State transitions are explicit.
- Behavior is not accidentally changed elsewhere.

### Security

- Inputs are validated and encoded.
- Authentication and authorization checks are preserved.
- Sensitive data is not logged, exposed, or stored incorrectly.
- Secrets are not committed.
- Dangerous file, shell, sql, or network operations are guarded.

### Performance

- No avoidable n+1 queries or repeated expensive calls.
- Rendering and effects do not loop unnecessarily.
- Large data sets are paginated, streamed, cached, or bounded.
- Bundle size and new dependencies are justified.

### Clean code

- Names explain intent.
- Functions and components have focused responsibility.
- Duplication is removed only when the abstraction is obvious.
- Error handling is explicit.
- Comments explain why, not obvious what.

### Clean architecture

- Business rules live in the right layer.
- UI, domain, data access, and infrastructure concerns remain separated when the repo pattern supports it.
- Public interfaces remain stable or migration is documented.
- The change fits existing module boundaries.

### UI/UX consistency

- Existing components and tokens are reused.
- Loading, empty, error, disabled, and success states are covered where relevant.
- Responsive behavior is intentional.
- Copy is clear and action-oriented.

### Accessibility

- Interactive elements are keyboard reachable.
- Labels, roles, headings, and landmarks are meaningful.
- Focus states are visible.
- Color is not the only signal.
- Dynamic updates are announced when needed.

### Testability

- Behavior-changing logic has tests.
- Tests exercise real behavior, not only mocks.
- Edge cases and regressions are covered.
- Tests are deterministic and easy to run.

### Maintainability

- Future extension path is clear.
- There are no hidden coupling points.
- Dependencies are minimal.
- Documentation or repo instructions are updated when needed.

## Release decision rubric

Use one of these outcomes:

### Ship

Use only when:

- relevant verification passed
- no blockers remain
- manual QA is small and well-defined
- rollback is simple or risk is low

### Ship with caution

Use when:

- implementation appears correct but verification is partial
- only minor or accepted major risks remain
- manual QA is required before or immediately after deploy
- rollback is clear

### Do not ship

Use when:

- tests, typecheck, lint, or build fail for the changed area
- blocker security, data, correctness, or migration risk remains
- requirements are incomplete
- no meaningful verification could be performed for risky work
