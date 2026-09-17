#!/usr/bin/env bash
set -euo pipefail

LOG_FILE=".claude/logs/skill-calls.log"
PASS=0
FAIL=0
WARN=0

if [ ! -f "$LOG_FILE" ]; then
  echo "FAIL: 日志文件不存在，先跑 run-prompts.sh 或手动跑 prompt"
  exit 1
fi

check() {
  local prompt_id="$1" must="$2" must_not="$3"
  local section
  section=$(awk "/MARKER:${prompt_id}:START/,/MARKER:${prompt_id}:END/" "$LOG_FILE")

  # 检查 MUST
  if [ -n "$must" ]; then
    if echo "$section" | grep -q "$must"; then
      echo "PASS: $prompt_id 触发 $must"
      PASS=$((PASS+1))
    else
      echo "FAIL: $prompt_id 未触发 $must"
      FAIL=$((FAIL+1))
    fi
  fi

  # 检查 MUST NOT
  if [ -n "$must_not" ]; then
    if echo "$section" | grep -q "$must_not"; then
      echo "FAIL: $prompt_id 触发了禁止的 $must_not"
      FAIL=$((FAIL+1))
    else
      echo "PASS: $prompt_id 未触发 $must_not"
      PASS=$((PASS+1))
    fi
  fi
}

echo "=========================================="
echo " L2 日志检查"
echo "=========================================="

check "P1" "grill-me" "brainstorming"
check "P2" "tdd" "test-driven-development"
check "P3" "diagnosing-bugs" ""
check "P4" "improve-codebase-architecture" ""
check "P5" "to-prd" "edit-article"

echo ""
echo "通过: $PASS, 失败: $FAIL"

if [ "$FAIL" -gt 0 ]; then
  exit 1
fi