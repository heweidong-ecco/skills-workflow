#!/usr/bin/env bash
set -euo pipefail

echo "=== T01 静态配置检查 ==="

# JSON 语法检查
if jq empty .claude/settings.json >/dev/null 2>&1; then
  echo "PASS: settings.json valid JSON"
else
  echo "FAIL: settings.json invalid JSON"
  exit 1
fi

# 检查 hooks.PreToolUse 存在
if jq -e '.hooks.PreToolUse' .claude/settings.json >/dev/null 2>&1; then
  echo "PASS: hooks.PreToolUse exists"
else
  echo "FAIL: hooks.PreToolUse missing"
  exit 1
fi

# 检查 permissions.deny 存在
if jq -e '.permissions.deny' .claude/settings.json >/dev/null 2>&1; then
  echo "PASS: permissions.deny exists"
else
  echo "FAIL: permissions.deny missing"
  exit 1
fi

# 检查 CLAUDE.md 长度
LINES=$(wc -l < CLAUDE.md)
if [ "$LINES" -le 60 ]; then
  echo "PASS: CLAUDE.md length $LINES lines"
else
  echo "WARN: CLAUDE.md length $LINES lines, consider trimming"
fi

# 检查 rules 下只有 .md 和 .txt
for f in .claude/rules/*; do
  case "$f" in
    *.md|*.txt) echo "PASS: rule file $f" ;;
    *) echo "WARN: non-md/txt file in rules: $f" ;;
  esac
done

echo "=== T01 通过 ==="