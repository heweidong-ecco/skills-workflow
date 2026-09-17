#!/usr/bin/env bash
set -euo pipefail

echo "=== T00 环境预检 ==="

check_cmd() {
  if command -v "$1" >/dev/null 2>&1; then
    echo "PASS: command $1"
  else
    echo "FAIL: command $1 not found"
    exit 1
  fi
}

check_file() {
  if [ -f "$1" ]; then
    echo "PASS: file $1"
  else
    echo "FAIL: file $1 missing"
    exit 1
  fi
}

check_cmd bash
check_cmd node
check_cmd npx
check_cmd jq || echo "WARN: jq not found, hook fallback will be used"

check_file CLAUDE.md
check_file .claude/settings.json
check_file .claude/hooks/skill-guard.sh
check_file .claude/rules/skills-routing.md
check_file .claude/rules/workflow.md
check_file .claude/rules/testing-gate.md
check_file .claude/rules/refactoring.md
check_file .claude/rules/conflict-resolution.md

if [ -x .claude/hooks/skill-guard.sh ]; then
  echo "PASS: skill-guard.sh executable"
else
  echo "FAIL: skill-guard.sh not executable"
  exit 1
fi

echo "=== T00 通过 ==="