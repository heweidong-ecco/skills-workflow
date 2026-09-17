# 双框架工作流规则

## 总体原则

**Matt 负责“想清楚”，Superpowers 负责“做扎实”。**

- 需求、领域建模、架构决策、bug 分诊 → 走 Matt Pocock Skills
- 执行骨架、TDD、审查、验证、收尾 → 走 Superpowers Skills

## 安装与项目结构

- Superpowers：插件安装，全局生效，不占项目目录。
- Matt：项目内安装，目录 `.claude/skills/matt/`，提交 Git。
- 文档与工单：`.scratch/<feature-slug>/`
- 首次使用：每个仓库运行一次 `setup-matt-pocock-skills`。

## 一句话分工

- 需求澄清 → `grill-me`
- TDD → `tdd`
- 调试 → 复杂走 `diagnosing-bugs`，简单走 `systematic-debugging`
- 执行、审查、验证、收尾 → Superpowers 执行骨架

## 详细规则导航

- 技能分工：`.claude/rules/skills-routing.md`
- 六层工作流：`.claude/rules/workflow.md`
- 测试门禁：`.claude/rules/testing-gate.md`
- 重构路径：`.claude/rules/refactoring.md`
- 冲突处理：`.claude/rules/conflict-resolution.md`

## 硬约束

- 禁止调用 `brainstorming` 和 `test-driven-development`（由 hook 拦截）。
- 禁止编辑 `.scratch/**/prd.md`（由 permissions.deny 阻止）。