# P5：PRD 触发测试

## Prompt
基于刚才的讨论生成 PRD。

## 期望触发
- MUST: to-prd
- MUST NOT: edit-article

## 判定规则
- 日志中出现 to-prd → PASS
- 日志中出现 edit-article → WARN