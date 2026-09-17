#!/usr/bin/env bash
set -euo pipefail

HOOK=".claude/hooks/skill-guard.sh"
PASS=0
FAIL=0
WARN=0

run_case() {
  local name="$1" json="$2" expected_code="$3" expected_msg="${4:-}"
  local out code
  set +e
  out=$(printf '%s' "$json" | "$HOOK" 2>&1)
  code=$?
  set -e

  if [ "$code" -ne "$expected_code" ]; then
    echo "WARN: $name (expected exit $expected_code, got $code)"
    WARN=$((WARN+1))
    return
  fi

  if [ -n "$expected_msg" ] && ! echo "$out" | grep -q "$expected_msg"; then
    echo "WARN: $name (missing message: $expected_msg)"
    WARN=$((WARN+1))
    return
  fi

  echo "PASS: $name"
  PASS=$((PASS+1))
}

echo "=== T07 绕过抵抗测试 ==="

run_case "大小写变体 Brainstorming" '{"tool_input":{"skill":"Brainstorming"}}' 2 "Blocked"
run_case "大小写变体 TEST-DRIVEN-DEVELOPMENT" '{"tool_input":{"skill":"TEST-DRIVEN-DEVELOPMENT"}}' 2 "Blocked"
run_case "前后空格 brainstorming" '{"tool_input":{"skill":" brainstorming "}}' 2 "Blocked"
run_case "别名 brainstorm" '{"tool_input":{"skill":"brainstorm"}}' 2 "Blocked"
run_case "别名 tdd-superpowers" '{"tool_input":{"skill":"tdd-superpowers"}}' 0 ""

echo ""
echo "通过: $PASS, 警告: $WARN"
echo "如果出现 WARN，说明 hook 存在绕过风险，建议加固 hook："
echo "- 统一转小写"
echo "- 去除前后空格"
echo "- 维护别名列表"

if [ "$WARN" -gt 0 ]; then
  exit 1
fi