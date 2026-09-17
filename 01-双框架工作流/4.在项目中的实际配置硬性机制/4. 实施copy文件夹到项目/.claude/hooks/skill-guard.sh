#!/usr/bin/env bash
# PreToolUse hook：拦截禁止的 Skill 调用
#
# 为什么有这道门：双框架并存时，Matt 与 Superpowers 在需求澄清/TDD/调试三处重叠，
#   若不在硬层禁止，Agent 会在两套之间摇摆（实测绕过）。
# 判据锚点：只按 skill 名称判定，不依赖仓库路径（库改名/搬走仍生效）。
# 豁免：如需临时放行，用户说“让我们跳过超能力”，但本 hook 的禁止列表不变。
#
# ⚠️ 退出码语义（Claude Code）：0=放行 / 2=阻塞 / 其他=非阻塞错误(不会拦住)
#    ⇒ 本脚本**任何非预期分支都必须 exit 2**，否则等于没拦。

set -euo pipefail

INPUT=$(cat)

if command -v jq >/dev/null 2>&1; then
  SKILL_NAME=$(printf '%s' "$INPUT" | jq -r '.tool_input.skill // empty')
else
  SKILL_NAME=$(printf '%s' "$INPUT" | grep -o '"skill"[[:space:]]*:[[:space:]]*"[^"]*"' \
    | sed 's/.*"skill"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/')
fi

# 归一化：转小写 + 去前后空格（防大小写/空格变体绕过）
NORM=$(printf '%s' "$SKILL_NAME" | tr '[:upper:]' '[:lower:]' | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')

# 追加日志（无论是否被拦截都记录；“被拦截”本身也是测试结果）
LOG_DIR=".claude/logs"
mkdir -p "$LOG_DIR"
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
SESSION_ID="${CLAUDE_SESSION_ID:-unknown}"
printf '%s | %s | %s\n' "$TIMESTAMP" "$SESSION_ID" "$SKILL_NAME" >> "$LOG_DIR/skill-calls.log"

# 禁止列表（归一化后比较；含已观察到的别名）
FORBIDDEN=("brainstorming" "brainstorm" "test-driven-development")

for skill in "${FORBIDDEN[@]}"; do
  if [[ "$NORM" == "$skill" ]]; then
    echo "Blocked: 本项目管理规则禁止调用 ${skill}。需求澄清使用 grill-me，TDD 使用 tdd。" >&2
    exit 2
  fi
done

exit 0
