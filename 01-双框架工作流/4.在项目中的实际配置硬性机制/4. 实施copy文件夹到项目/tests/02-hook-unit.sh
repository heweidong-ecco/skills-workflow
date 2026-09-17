#!/usr/bin/env bash
set -euo pipefail

HOOK=".claude/hooks/skill-guard.sh"
PASS=0
FAIL=0

run_case() {
  local name="$1" json="$2" expected_code="$3" expected_msg="${4:-}"
  local out code
  set +e
  out=$(printf '%s' "$json" | "$HOOK" 2>&1)
  code=$?
  set -e

  if [ "$code" -ne "$expected_code" ]; then
    echo "FAIL: $name (expected exit $expected_code, got $code)"
    echo "      output: $out"
    FAIL=$((FAIL+1))
    return
  fi

  if [ -n "$expected_msg" ] && ! echo "$out" | grep -q "$expected_msg"; then
    echo "FAIL: $name (missing message: $expected_msg)"
    echo "      output: $out"
    FAIL=$((FAIL+1))
    return
  fi

  echo "PASS: $name"
  PASS=$((PASS+1))
}

echo "=== T02 Hook 单元测试 ==="

run_case "禁止 brainstorming" '{"tool_input":{"skill":"brainstorming"}}' 2 "Blocked"
run_case "禁止 test-driven-development" '{"tool_input":{"skill":"test-driven-development"}}' 2 "Blocked"
run_case "允许 grill-me" '{"tool_input":{"skill":"grill-me"}}' 0 ""
run_case "允许 tdd" '{"tool_input":{"skill":"tdd"}}' 0 ""
run_case "允许 diagnosing-bugs" '{"tool_input":{"skill":"diagnosing-bugs"}}' 0 ""
run_case "允许 systematic-debugging" '{"tool_input":{"skill":"systematic-debugging"}}' 0 ""
run_case "无 skill 字段" '{"tool_input":{}}' 0 ""
run_case "空输入" '' 0 ""
run_case "非法 JSON" 'not-json' 0 ""

echo ""
echo "通过: $PASS, 失败: $FAIL"
if [ "$FAIL" -gt 0 ]; then
  exit 1
fi