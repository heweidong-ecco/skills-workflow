---
paths: ".claude/skills/**, .scratch/**, **/*.ts, **/*.js, **/*.py"
---
# 技能分工规则

## 需求澄清
- 只使用 Matt 的 `grill-me`。
- 不使用 Superpowers 的 `brainstorming`（由 hook 强制拦截）。

## TDD
- 只使用 Matt 的 `tdd`。
- 不使用 Superpowers 的 `test-driven-development`（由 hook 强制拦截）。

## 调试
- 复杂问题（多组件、跨模块、根因不明、已尝试多次修复未果）→ `diagnosing-bugs`
- 简单问题（单一文件、错误信息明确、可快速复现）→ `systematic-debugging`
- 无法判断复杂度时，默认走 `diagnosing-bugs`。

## 执行骨架
- 执行、审查、验证、收尾全部走 Superpowers：
  `using-git-worktrees` → `subagent-driven-development` / `executing-plans` → `requesting-code-review` → `receiving-code-review` → `verification-before-completion` → `finishing-a-development-branch`
- Matt 的 `tdd` 嵌入执行骨架内部。