#!/usr/bin/env bash
set -euo pipefail

if [ -z "${RESULT:-}" ]; then
  echo "エラー: RESULT環境変数が設定されていません" >&2
  exit 1
fi

MUST_COUNT=$(echo "$RESULT" | sed '/^```/d' | jq '[.issues[] | select(.priority=="must")] | length' 2>/dev/null || echo "0")

echo "mustの問題件数: ${MUST_COUNT}"

if [ "$MUST_COUNT" -ge 2 ]; then
  echo "mustの問題が${MUST_COUNT}件あります。pushを中断します。" >&2
  exit 1
fi

echo "コードレビューを通過しました。"
exit 0
