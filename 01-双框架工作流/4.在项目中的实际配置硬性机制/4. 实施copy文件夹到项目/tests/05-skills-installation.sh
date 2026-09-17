#!/usr/bin/env bash
set -euo pipefail

echo "=== T05 技能安装检查 ==="

# 检查 Matt 技能目录
if [ -d ".claude/skills/matt" ]; then
  COUNT=$(find .claude/skills/matt -name 'SKILL.md' | wc -l)
  echo "PASS: Matt skills directory exists, $COUNT SKILL.md files"
else
  echo "FAIL: Matt skills directory missing"
  exit 1
fi

# 检查 Superpowers 插件
if command -v claude >/dev/null 2>&1; then
  if claude plugin list 2>/dev/null | grep -qi superpowers; then
    echo "PASS: Superpowers plugin installed"
  else
    echo "FAIL: Superpowers plugin not found in claude plugin list"
    exit 1
  fi
else
  echo "WARN: claude command not found, skip plugin list check"
fi

# 检查 setup-matt-pocock-skills 是否运行过
if [ -f ".scratch/.setup-matt-pocock-skills" ] || grep -rq "setup-matt-pocock-skills" CLAUDE.md .claude/rules/ 2>/dev/null; then
  echo "PASS: setup-matt-pocock-skills referenced"
else
  echo "WARN: setup-matt-pocock-skills not referenced, run it manually"
fi

echo "=== T05 完成 ==="