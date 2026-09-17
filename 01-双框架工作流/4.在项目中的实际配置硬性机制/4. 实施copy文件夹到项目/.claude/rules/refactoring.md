---
paths: "src/**, lib/**, packages/**, **/*.ts, **/*.js, **/*.py"
---
# 重构路径

## Bug 路径
1. `triage-issue`：调查报告的 bug，定位根因。
2. `diagnosing-bugs`：6 阶段诊断循环。
3. 修复后回到执行循环。

## 架构重构路径
1. `improve-codebase-architecture`：发现架构摩擦。
2. `design-an-interface`：设计目标接口。
3. `request-refactor-plan`：制定微小提交计划。
4. `to-issues`：拆成工单。
5. 回到执行循环。

## 严禁混用
- `triage-issue` 是 bug 分诊，不是重构。
- `diagnosing-bugs` 是 bug 诊断，不是重构规划。
- `design-an-interface` 是重构子步骤，不单独用于 bug。