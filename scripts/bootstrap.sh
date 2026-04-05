#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# bootstrap.sh — 他プロジェクトへの導入スクリプト
# 使い方:
#   curl -sL https://raw.githubusercontent.com/taka1156/skills/master/scripts/bootstrap.sh | bash
# ============================================================

echo "[INFO]  template ブランチのファイルを展開します..."
curl -sL https://github.com/taka1156/skills/archive/refs/heads/template.tar.gz \
  | tar -xz --strip-components=1

echo "[INFO]  依存パッケージをインストールします..."
sudo bash scripts/install.sh

echo "[INFO]  セットアップを実行します..."
bash scripts/setup.sh
