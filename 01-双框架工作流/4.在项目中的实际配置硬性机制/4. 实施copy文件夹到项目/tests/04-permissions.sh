#!/usr/bin/env bash
set -euo pipefail

echo "=== T04 Permissions 检查 ==="

if jq -e '.permissions.deny[] | select(test("prd\\.md"))' .claude/settings.json >/dev/null 2>&1; then
  echo "PASS: permissions.deny contains prd.md rule"
else
  echo "FAIL: permissions.deny missing prd.md rule"
  exit 1
fi

echo ""
echo "手动测试步骤："
echo "1. 在 Claude Code 中执行：尝试编辑 .scratch/demo/prd.md"
echo "2. 预期：编辑被拒绝，提示权限不足"
echo "3. 如果未被拒绝，检查 settings.json 语法和权限模式"

echo "=== T04 完成 ==="