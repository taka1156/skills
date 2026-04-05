# skills

GitHub Copilot を使った自動コードレビューシステムです。`git push` 時に pre-push フックとして実行されます。

[English version](README.md)

## 概要

`git push` のたびに以下を自動で行います：

1. 現在のブランチとリモートの追跡ブランチとの差分を取得
2. GitHub Copilot API に差分を送信してコードレビューを実施
3. レビュー結果を `copilot-review/review.md` に保存
4. `must` 優先度の問題が 2 件以上あれば push をブロック

## 必要なもの

- [lefthook](https://github.com/evilmartians/lefthook)
- [GitHub CLI (`gh`)](https://cli.github.com/) — `gh auth login` で認証済みであること
- `jq`
- 有効な GitHub Copilot サブスクリプション

## セットアップ

### Dev Container を使う場合（推奨）

VS Code の Dev Containers 拡張機能でこのリポジトリを開いてください。コンテナは Alpine Linux ベースで、必要な依存関係がすべて含まれています。

### 手動セットアップ

lefthook をインストールして git フックを登録します：

```sh
lefthook install
```

## 使い方

### 自動実行（push 時）

`git push` 時にレビューが自動で実行されます。`must` 優先度の問題が 2 件以上検出された場合、push がブロックされます。

### ドライラン

push せずにレビューだけ実行する場合：

```sh
lefthook run pre-push
```

### 言語オプション

デフォルトは日本語でレビューされます。英語に切り替える場合：

```sh
bash scripts/run-copilot-review.sh --lang=en
```

## レビュー結果

結果は `copilot-review/review.md` に保存されます（`.gitignore` によりバージョン管理対象外 — このファイルはローカルのレビュー成果物であり、コミットは想定されていません）。

### 優先度ラベル

優先度ラベルは以下の記事で紹介されているレビューコメントのプレフィックス規約をベースにしています：

> [よく使うレビューコメントのプレフィックスまとめ — Classmethod Developers IO](https://dev.classmethod.jp/articles/prefixes-for-frequently-used-review-comments/)

| ラベル | 意味 |
|--------|------|
| 🔴 `must` | 必ず修正してほしい |
| 🟠 `want` | 修正してほしい |
| 🟡 `imo` | 意見として修正した方が良いと感じている（他の人もそうかも） |
| 🟡 `imho` | 意見として修正した方が良いと感じている（他の人は違うかも） |
| 🔵 `nits` | 些細な指摘 |
| 💬 `info` | アドバイスや共有事項 |
| ❓ `ask` | 質問（修正は不要） |

## スキル

`.github/skills/` 以下に 2 つの Copilot スキル定義が含まれています：

| スキル | 説明 |
|--------|------|
| `git-hook-code-review` | git フックで使うための構造化 JSON を出力する |
| `chat-code-review` | チャットで使うための絵文字付きマークダウンを出力する |

## ファイル構成

```
.github/skills/          # Copilot スキル定義
scripts/
  run-copilot-review.sh  # Copilot API を呼び出してレビュー結果を生成
review-check.sh          # レビュー結果を確認し、must 問題があれば push をブロック
lefthook.yml             # git フック設定
copilot-review/          # レビュー出力ディレクトリ（gitignore 済み）
```
