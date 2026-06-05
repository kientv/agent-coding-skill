#!/usr/bin/env bash
set -euo pipefail

REPO_RAW_BASE="${REPO_RAW_BASE:-https://raw.githubusercontent.com/kientv/agent-coding-skill/main}"
SOURCE_URL="${SOURCE_URL:-$REPO_RAW_BASE/AGENTS.md}"

MARKER_START="<!-- agent-coding-skill:start -->"
MARKER_END="<!-- agent-coding-skill:end -->"

DRY_RUN=0
UNINSTALL=0
INSTALL_AGENTS=0
INSTALL_CLAUDE=0
INSTALL_COPILOT=0
INSTALL_CURSOR=0
INSTALL_WINDSURF=0
INSTALL_ANTIGRAVITY=0
INSTALL_ALL=0

usage() {
  cat <<'EOF'
Agent Coding Skill installer

Usage:
  install.sh [options]

Default:
  install.sh
    Install only AGENTS.md

Options:
  --agents       Install AGENTS.md
  --claude       Install CLAUDE.md
  --copilot      Install .github/copilot-instructions.md
  --cursor       Install .cursor/rules/agent-coding-skill.mdc
  --windsurf     Install .windsurfrules
  --antigravity  Install .agents/rules/agent-coding-skill.md
  --all          Install all supported instruction files

  --dry-run      Show what would change without modifying files
  --uninstall    Remove the agent-coding-skill block from selected files
  -h, --help     Show this help

Examples:
  curl -fsSL https://raw.githubusercontent.com/kientv/agent-coding-skill/main/install.sh | bash

  curl -fsSL https://raw.githubusercontent.com/kientv/agent-coding-skill/main/install.sh | bash -s -- --claude

  curl -fsSL https://raw.githubusercontent.com/kientv/agent-coding-skill/main/install.sh | bash -s -- --all --dry-run

  curl -fsSL https://raw.githubusercontent.com/kientv/agent-coding-skill/main/install.sh | bash -s -- --all --uninstall
EOF
}

log() {
  printf '%s\n' "$*"
}

die() {
  printf 'Error: %s\n' "$*" >&2
  exit 1
}

has_cmd() {
  command -v "$1" >/dev/null 2>&1
}

download_source() {
  if has_cmd curl; then
    curl -fsSL "$SOURCE_URL"
  elif has_cmd wget; then
    wget -qO- "$SOURCE_URL"
  else
    die "curl or wget is required to download $SOURCE_URL"
  fi
}

backup_file() {
  target="$1"

  if [ ! -f "$target" ]; then
    return 0
  fi

  timestamp="$(date +%Y%m%d%H%M%S)"
  cp "$target" "$target.bak.$timestamp"
}

strip_skill_block() {
  awk -v start="$MARKER_START" -v end="$MARKER_END" '
    $0 == start { skipping=1; next }
    $0 == end { skipping=0; next }
    skipping != 1 { print }
  '
}

trim_trailing_blank_lines() {
  awk '
    { lines[NR]=$0 }
    END {
      last=NR
      while (last > 0 && lines[last] == "") last--
      for (i=1; i<=last; i++) print lines[i]
    }
  '
}

render_block() {
  printf '%s\n' "$MARKER_START"
  printf '%s\n' ""
  printf '%s\n' "$CONTENT"
  printf '%s\n' ""
  printf '%s\n' "$MARKER_END"
}

would_install_message() {
  target="$1"
  if [ -f "$target" ]; then
    log "[DRY RUN] Would update $target"
  else
    log "[DRY RUN] Would create $target"
  fi
}

install_file() {
  target="$1"

  if [ "$DRY_RUN" = "1" ]; then
    would_install_message "$target"
    return 0
  fi

  dir="$(dirname "$target")"
  if [ "$dir" != "." ]; then
    mkdir -p "$dir"
  fi

  tmp="$(mktemp)"
  if [ -f "$target" ]; then
    strip_skill_block < "$target" | trim_trailing_blank_lines > "$tmp"
  else
    : > "$tmp"
  fi

  backup_file "$target"

  {
    if [ -s "$tmp" ]; then
      cat "$tmp"
      printf '\n\n'
    fi
    render_block
    printf '\n'
  } > "$target"

  rm -f "$tmp"
  log "Installed $target"
}

uninstall_file() {
  target="$1"

  if [ ! -f "$target" ]; then
    if [ "$DRY_RUN" = "1" ]; then
      log "[DRY RUN] Would skip missing $target"
    else
      log "Skipped missing $target"
    fi
    return 0
  fi

  if ! grep -Fq "$MARKER_START" "$target"; then
    if [ "$DRY_RUN" = "1" ]; then
      log "[DRY RUN] Would skip $target because no managed block was found"
    else
      log "Skipped $target because no managed block was found"
    fi
    return 0
  fi

  if [ "$DRY_RUN" = "1" ]; then
    log "[DRY RUN] Would remove managed block from $target"
    return 0
  fi

  backup_file "$target"

  tmp="$(mktemp)"
  strip_skill_block < "$target" | trim_trailing_blank_lines > "$tmp"

  if [ -s "$tmp" ]; then
    cat "$tmp" > "$target"
    printf '\n' >> "$target"
    log "Removed managed block from $target"
  else
    rm -f "$target"
    log "Removed empty $target"
  fi

  rm -f "$tmp"
}

select_defaults_if_needed() {
  if [ "$INSTALL_AGENTS" = "0" ] \
    && [ "$INSTALL_CLAUDE" = "0" ] \
    && [ "$INSTALL_COPILOT" = "0" ] \
    && [ "$INSTALL_CURSOR" = "0" ] \
    && [ "$INSTALL_WINDSURF" = "0" ] \
    && [ "$INSTALL_ANTIGRAVITY" = "0" ] \
    && [ "$INSTALL_ALL" = "0" ]; then
    INSTALL_AGENTS=1
  fi

  if [ "$INSTALL_ALL" = "1" ]; then
    INSTALL_AGENTS=1
    INSTALL_CLAUDE=1
    INSTALL_COPILOT=1
    INSTALL_CURSOR=1
    INSTALL_WINDSURF=1
    INSTALL_ANTIGRAVITY=1
  fi
}

run_for_selected_targets() {
  action="$1"

  if [ "$INSTALL_AGENTS" = "1" ]; then
    "$action" "AGENTS.md"
  fi

  if [ "$INSTALL_CLAUDE" = "1" ]; then
    "$action" "CLAUDE.md"
  fi

  if [ "$INSTALL_COPILOT" = "1" ]; then
    "$action" ".github/copilot-instructions.md"
  fi

  if [ "$INSTALL_CURSOR" = "1" ]; then
    "$action" ".cursor/rules/agent-coding-skill.mdc"
  fi

  if [ "$INSTALL_WINDSURF" = "1" ]; then
    "$action" ".windsurfrules"
  fi

  if [ "$INSTALL_ANTIGRAVITY" = "1" ]; then
    "$action" ".agents/rules/agent-coding-skill.md"
  fi
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --agents)
      INSTALL_AGENTS=1
      ;;
    --claude)
      INSTALL_CLAUDE=1
      ;;
    --copilot)
      INSTALL_COPILOT=1
      ;;
    --cursor)
      INSTALL_CURSOR=1
      ;;
    --windsurf)
      INSTALL_WINDSURF=1
      ;;
    --antigravity)
      INSTALL_ANTIGRAVITY=1
      ;;
    --all)
      INSTALL_ALL=1
      ;;
    --dry-run)
      DRY_RUN=1
      ;;
    --uninstall)
      UNINSTALL=1
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      die "unknown option: $1"
      ;;
  esac
  shift
done

select_defaults_if_needed

if [ "$UNINSTALL" = "1" ]; then
  run_for_selected_targets uninstall_file

  if [ "$DRY_RUN" = "1" ]; then
    log "Dry run complete. No files were modified."
  else
    log "Uninstall complete."
  fi

  exit 0
fi

CONTENT="$(download_source)"

if [ -z "${CONTENT:-}" ]; then
  die "downloaded AGENTS.md is empty"
fi

run_for_selected_targets install_file

if [ "$DRY_RUN" = "1" ]; then
  log "Dry run complete. No files were modified."
else
  log "Done. Open your AI coding tool in this repository and ask it to follow the project instructions."
fi
