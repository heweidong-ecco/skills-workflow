#!/usr/bin/env bash
set -euo pipefail

LOG_FILE=".claude/logs/skill-calls.log"
mkdir -p .claude/logs
: > "$LOG_FILE"

echo "=========================================="
echo " L2 Prompt 触发测试"
echo "=========================================="

PROMPTS=(
  "帮我加一个用户登录功能。"
  "实现用户登录接口。"
  "登录接口返回 500 了，帮我看看。"
  "这个模块太耦合了，帮我改进架构。"
  "基于刚才的讨论生成 PRD。"
)

for i in "${!PROMPTS[@]}"; do
  N=$((i+1))
  PROMPT="${PROMPTS[$i]}"
  echo ""
  echo "--- P$N: $PROMPT ---"
  echo "MARKER:P$N:START" >> "$LOG_FILE"
  claude -p "$PROMPT" --output-format text > /dev/null 2>&1 || true
  echo "MARKER:P$N:END" >> "$LOG_FILE"
  echo "P$N 完成"
done

echo ""
echo "=========================================="
echo " 日志已写入 $LOG_FILE"
echo " 运行 tests/check-prompt-log.sh 验证"
echo "=========================================="