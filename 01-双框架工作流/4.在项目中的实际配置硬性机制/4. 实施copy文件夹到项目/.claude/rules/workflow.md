---
paths: ".scratch/**, docs/**, **/*.md"
---
# 六层工作流

## 第 0 层：环境配置
- 安装 Matt 和 Superpowers。
- 运行 `setup-matt-pocock-skills`。
- 运行 `setup-pre-commit`。
- 运行 `git-guardrails-claude-code`。
- 如需子代理，启用 Superpowers 多代理。

## 第 1 层：模糊需求 → 清晰 PRD
- `grill-me` → `domain-model` → `to-prd`。
- 不使用 `edit-article`。
- 不使用 `brainstorming`。

## 第 2 层：PRD → 可执行工单
- `to-issues`：拆成垂直切片，按依赖排序。
- 每个 issue 包含验收标准、测试要求、依赖关系。
- 复杂 issue 可用 `writing-plans` 写局部微计划，不要每个都写。

## 第 3 层：每个 issue 的执行循环
- `using-git-worktrees` → `subagent-driven-development` 或 `executing-plans` → `tdd` → `requesting-code-review` → `receiving-code-review` → `verification-before-completion` → `finishing-a-development-branch`。

## 第 4 层：测试检查阶段
- 提交前：`setup-pre-commit` 自动跑 lint、类型、单元测试。
- 任务完成：`tdd` + `verification-before-completion`。
- 分支完成：全量测试 + `requesting-code-review`。
- 端到端：`agent-browser` 或 `webapp-testing`。
- 失败诊断：`diagnosing-bugs`（复杂）或 `systematic-debugging`（简单）。
- 人工验收：用户最终确认。

## 第 5 层：修改与重构
- Bug 路径：`triage-issue` → `diagnosing-bugs` → 修复 → 回到执行循环。
- 重构路径：`improve-codebase-architecture` → `design-an-interface` → `request-refactor-plan` → `to-issues` → 回到执行循环。
- 严禁混用。

## 第 6 层：阶段完成
- `verification-before-completion` → `requesting-code-review` → 全量测试 + 人工验收 → `finishing-a-development-branch`。