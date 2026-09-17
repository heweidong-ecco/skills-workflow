---
paths: ".claude/**, CLAUDE.md"
---
# 冲突处理

- 本文件的分工规则优先级高于 `using-superpowers` 的默认触发规则。
- 当 `using-superpowers` 强制检查与 Matt 技能触发冲突时，以 `skills-routing.md` 为准。
- 子代理不继承启动注入的上下文；若发现子代理跳过规则，手动触发 `using-superpowers` 将其拉回，并重申 `skills-routing.md` 的归属声明。
- 如需临时停用 Superpowers 全套规则，用户可说“让我们跳过超能力”，但 `skills-routing.md` 的分工规则仍然生效。