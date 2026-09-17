#!/usr/bin/env bash
set -euo pipefail

echo "=========================================="
echo " L1 静态测试套件"
echo "=========================================="

bash tests/00-preflight.sh
echo ""
bash tests/01-static-config.sh
echo ""
bash tests/02-hook-unit.sh
echo ""
bash tests/03-rules-loading.sh
echo ""
bash tests/04-permissions.sh
echo ""
bash tests/07-bypass-resistance.sh

echo ""
echo "=========================================="
echo " L1 全部通过"
echo "=========================================="