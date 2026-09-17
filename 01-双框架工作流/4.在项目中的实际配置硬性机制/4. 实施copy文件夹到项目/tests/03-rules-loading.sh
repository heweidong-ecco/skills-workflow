#!/usr/bin/env bash
set -euo pipefail

echo "=== T03 Rules 加载检查 ==="

check_frontmatter() {
  local file="$1"
  if head -n 1 "$file" | grep -q '^---$'; then
    echo "PASS: $file has frontmatter"
  else
    echo "FAIL: $file missing frontmatter"
    exit 1
  fi
}

check_paths_format() {
  local file="$1"
  local line
  line=$(grep -m1 '^paths:' "$file" || true)
  if [ -z "$line" ]; then
    echo "WARN: $file no paths field"
    return
  fi
  if echo "$line" | grep -q '\[.*\]'; then
    echo "FAIL: $file paths uses YAML array, will be silently ignored"
    exit 1
  fi
  if echo "$line" | grep -q '"'; then
    echo "PASS: $file paths is quoted string"
  else
    echo "WARN: $file paths not quoted, may still work"
  fi
}

for f in .claude/rules/*.md; do
  check_frontmatter "$f"
  check_paths_format "$f"
done

echo "=== T03 通过 ==="