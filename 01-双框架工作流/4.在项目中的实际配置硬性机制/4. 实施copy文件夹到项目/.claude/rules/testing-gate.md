---
paths: "**/*.test.ts, **/*.spec.ts, **/*.test.js, **/*.spec.js, **/test/**, **/tests/**"
---
# 测试检查阶段

## 提交前
- `setup-pre-commit` 自动跑 lint、类型检查、单元测试。

## 任务完成
- `tdd` 保证红-绿-重构循环。
- `verification-before-completion`：必须运行验证命令并确认输出。

## 分支完成
- 全量测试。
- `requesting-code-review`。

## 端到端
- `agent-browser` 或 `webapp-testing`。

## 失败诊断
- 复杂问题 → `diagnosing-bugs`
- 简单问题 → `systematic-debugging`

## 人工验收
- 用户最终确认，无法自动化替代。