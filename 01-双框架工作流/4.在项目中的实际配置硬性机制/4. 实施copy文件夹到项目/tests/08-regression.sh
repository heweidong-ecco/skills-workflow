#!/usr/bin/env bash
set -euo pipefail

echo "=== T08 回归测试 ==="

bash tests/00-preflight.sh
bash tests/01-static-config.sh
bash tests/02-hook-unit.sh
bash tests/03-rules-loading.sh
bash tests/04-permissions.sh
bash tests/05-skills-installation.sh
bash tests/07-bypass-resistance.sh

echo ""
echo "=== T08 回归测试通过 ==="