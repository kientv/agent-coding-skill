# Agent Coding Skill

A structured coding workflow for AI coding assistants, packaged as both a one-command instruction installer and a Claude Code / Codex-compatible skill plugin.

Agent Coding Skill makes AI coding tools behave more like careful pair programmers: understand first, plan briefly, implement small changes, verify with evidence, review the diff, and give a release decision.

It supports common agent instruction files used by tools such as Codex, Antigravity, GitHub Copilot, Cursor, Windsurf, Claude Code, and other AI coding assistants. It also includes `.claude-plugin/plugin.json`, `.codex-plugin/plugin.json`, and `skills/ai-coding-skill/SKILL.md` for plugin-style discovery.

## Repository structure

```txt
AGENTS.md                         Canonical workflow installed into target repos
SKILL.md                          Root skill entrypoint
skills/ai-coding-skill/SKILL.md   Codex plugin skill entrypoint
skills/ai-coding-skill/agents/    Skill UI metadata
.claude-plugin/plugin.json        Claude Code plugin manifest
.codex-plugin/plugin.json         Codex plugin manifest
references/                       Review, design-system, and teach-back references
install.sh                        Instruction-file installer
```

## Install as repo instructions

Run this command from the root of the project where you want to install the workflow:

```bash
curl -fsSL https://raw.githubusercontent.com/kientv/agent-coding-skill/main/install.sh | bash
```

By default, the installer writes the workflow into common instruction files:

```txt
AGENTS.md
CLAUDE.md
.github/copilot-instructions.md
.cursor/rules/agent-coding-skill.mdc
.windsurfrules
.agents/rules/agent-coding-skill.md
```

The installer does not overwrite your whole files. It updates only the managed block between these markers:

```md
<!-- agent-coding-skill:start -->
...
<!-- agent-coding-skill:end -->
```

## Preview before installing

Use `--dry-run` to see what would change without writing files:

```bash
curl -fsSL https://raw.githubusercontent.com/kientv/agent-coding-skill/main/install.sh | bash -s -- --all --dry-run
```

## Uninstall

Remove the managed Agent Coding Skill blocks from all supported instruction files:

```bash
curl -fsSL https://raw.githubusercontent.com/kientv/agent-coding-skill/main/install.sh | bash -s -- --all --uninstall
```

This removes only the block between:

```md
<!-- agent-coding-skill:start -->
<!-- agent-coding-skill:end -->
```

Any other project-specific instructions in those files are kept.

## Install for a specific tool

Install only one target when you do not want to create all instruction files.

```bash
# Generic coding agents / Codex-style agents
curl -fsSL https://raw.githubusercontent.com/kientv/agent-coding-skill/main/install.sh | bash -s -- --agents

# Claude Code
curl -fsSL https://raw.githubusercontent.com/kientv/agent-coding-skill/main/install.sh | bash -s -- --claude

# GitHub Copilot
curl -fsSL https://raw.githubusercontent.com/kientv/agent-coding-skill/main/install.sh | bash -s -- --copilot

# Cursor
curl -fsSL https://raw.githubusercontent.com/kientv/agent-coding-skill/main/install.sh | bash -s -- --cursor

# Windsurf
curl -fsSL https://raw.githubusercontent.com/kientv/agent-coding-skill/main/install.sh | bash -s -- --windsurf

# Antigravity
curl -fsSL https://raw.githubusercontent.com/kientv/agent-coding-skill/main/install.sh | bash -s -- --antigravity
```

## What gets installed?

The installer downloads the canonical workflow from:

```txt
https://raw.githubusercontent.com/kientv/agent-coding-skill/main/AGENTS.md
```

Then it injects that workflow into the selected instruction files.

The installed workflow is intentionally compact. Detailed review, frontend, and teach-back guidance lives in `references/` and should be loaded only when the task needs it.

The workflow asks the AI assistant to follow this loop:

```txt
Understand -> Plan -> Implement -> Verify -> Review -> Release decision
```

For frontend work, it also tells the assistant to:

- follow the existing design system,
- reuse existing components,
- avoid random one-off styling,
- handle loading, empty, error, disabled, and success states,
- consider responsive behavior and accessibility.

For release readiness, it asks the assistant to end substantial tasks with:

```txt
Release recommendation: Ship | Ship with caution | Do not ship
Blockers
Non-blocking issues
Required manual QA
Rollback plan
Confidence
```

## Why use this?

Most AI coding failures come from the same pattern: the assistant jumps into code too early, guesses project conventions, skips verification, and then says the work is done without enough evidence.

Agent Coding Skill fixes that by giving the assistant a repeatable workflow:

1. Understand the requirement and project context.
2. Plan the smallest safe change.
3. Implement according to existing conventions.
4. Verify with lint, typecheck, tests, or build commands.
5. Review the final diff.
6. Make a clear release decision.

## Recommended repo setup

Commit these files to your repository:

```txt
AGENTS.md
install.sh
README.md
SKILL.md
.claude-plugin/plugin.json
.codex-plugin/plugin.json
skills/ai-coding-skill/SKILL.md
skills/ai-coding-skill/agents/openai.yaml
```

Then each project can install or update the workflow with one command.

## Update

Re-run the install command from the root of the target project:

```bash
curl -fsSL https://raw.githubusercontent.com/kientv/agent-coding-skill/main/install.sh | bash
```

Because the installer uses managed markers, re-running it updates the Agent Coding Skill block without deleting your own project-specific instructions.

## Local development

From this repository, you can test the installer locally:

```bash
bash install.sh --all --dry-run
bash install.sh --all
bash install.sh --all --uninstall
```

You can also validate the plugin manifest and skill metadata locally:

```bash
python3 -m json.tool .codex-plugin/plugin.json
python3 -m json.tool .claude-plugin/plugin.json
test -f skills/ai-coding-skill/SKILL.md
```

## Notes

- `AGENTS.md` is the canonical source for installed repo instructions.
- `SKILL.md` and `skills/ai-coding-skill/SKILL.md` expose the workflow as skill metadata.
- Tool-specific instruction files are generated from `AGENTS.md`.
- The installer is safe to re-run.
- Project-specific instructions outside the managed block are preserved.
- Use `--dry-run` before installing in an important repo.
