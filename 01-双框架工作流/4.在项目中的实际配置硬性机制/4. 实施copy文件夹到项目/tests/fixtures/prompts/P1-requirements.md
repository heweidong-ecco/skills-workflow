# P1：需求澄清触发测试

## Prompt
帮我加一个用户登录功能。

## 期望触发
- MUST: grill-me
- MUST NOT: brainstorming

## 判定规则
- 日志中出现 grill-me → PASS
- 日志中出现 brainstorming → FAIL（被拦截算 PASS）
- 两者都未出现 → WARN