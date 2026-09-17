# T06 工作流端到端测试（手动）

## 测试目标
验证从模糊需求到分支收尾的完整双框架工作流可用。

## 步骤

### 1. 需求澄清
- 在 Claude Code 输入：帮我加一个用户登录功能。
- 预期：自动触发 `grill-me`，开始盘问需求，不触发 `brainstorming`。
- 若触发错误，检查 `.claude/rules/skills-routing.md` 是否加载。

### 2. 领域建模
- 在盘问过程中，输入：提取一下统一语言。
- 预期：触发 `domain-model`，输出领域词汇表。
- 记录输出，确认与项目术语一致。

### 3. 生成 PRD
- 输入：生成 PRD。
- 预期：触发 `to-prd`，生成 PRD 并发布到 issue tracker。
- 确认 PRD 中包含 Problem Statement、User Stories、Implementation Decisions、Testing Decisions、Out of Scope。

### 4. 拆分工单
- 输入：拆成 issues。
- 预期：触发 `to-issues`，拆成垂直切片，按依赖排序。
- 检查每个 issue 有验收标准、测试要求、依赖关系。

### 5. 执行一个 issue
- 选择第一个 issue，输入：执行这个 issue。
- 预期：
  - 触发 `using-git-worktrees` 创建隔离工作区。
  - 触发 `subagent-driven-development` 或 `executing-plans`。
  - 在实现前触发 `tdd`，而不是 `test-driven-development`。
  - 任务间触发 `requesting-code-review`。
  - 完成前触发 `verification-before-completion`。
  - 最后触发 `finishing-a-development-branch`。

### 6. 测试检查
- 在提交前，确认 `setup-pre-commit` 已运行。
- 在任务完成时，确认 `tdd` 和 `verification-before-completion` 都已执行。
- 在分支完成时，确认全量测试和 `requesting-code-review` 都已执行。
- 端到端可尝试 `agent-browser` 或 `webapp-testing`。

### 7. 模拟 Bug
- 故意引入一个 bug，输入：这个功能报错了，帮我看看。
- 预期：
  - 复杂问题走 `diagnosing-bugs`，简单问题走 `systematic-debugging`。
  - 修复后回到执行循环。

### 8. 模拟重构
- 输入：这个模块架构有问题，帮我改进。
- 预期：
  - 触发 `improve-codebase-architecture`。
  - 选择候选后，触发 `design-an-interface` 和 `request-refactor-plan`。
  - 用 `to-issues` 拆成工单。
  - 回到执行循环。

### 9. 阶段完成
- 输入：这个阶段完成了。
- 预期：
  - 触发 `verification-before-completion`。
  - 触发 `requesting-code-review`。
  - 全量测试通过。
  - 人工验收后触发 `finishing-a-development-branch`。

## 记录
- 每个步骤是否触发正确技能：是/否
- 是否有技能被 hook 误拦截：是/否
- 是否有技能绕过 rules：是/否
- 备注：