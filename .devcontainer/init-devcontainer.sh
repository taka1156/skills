#!/usr/bin/env bash
set -euo pipefail

lefthook install

# gh認証状態を確認し、未認証の場合はガイドを表示
if ! gh auth status &>/dev/null; then
  echo ""
  echo "========================================="
  echo " GitHub CLIの認証が必要です"
  echo "-----------------------------------------"
  echo " scripts/run-copilot-review.sh を使うには"
  echo " 以下のコマンドで認証してください:"
  echo ""
  echo "   gh auth login"
  echo ""
  echo " Copilot拡張も必要な場合:"
  echo "   gh extension install github/gh-copilot"
  echo "========================================="
  echo ""
fi
