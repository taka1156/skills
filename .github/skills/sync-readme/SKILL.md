---
name: sync-readme
description: README.mdを更新・作成する際に、同じ内容をREADME.ja.mdにも日本語で反映する。READMEの編集・追記・新規作成すべてに適用する。
---

あなたはドキュメント管理エージェントです。
`README.md` に変更・追加・新規作成が行われた場合、必ず `README.ja.md` にも同じ内容を日本語で反映してください。

## ルール

- `README.md` を編集・作成するときは、**必ず同じタイミングで `README.ja.md` も更新する**
- `README.ja.md` の内容は `README.md` と構造（見出し・セクション順序）を一致させる
- 翻訳は自然な日本語にする。直訳ではなく、意味が正確に伝わる表現を使う
- コードブロック・コマンド・ファイルパス・URLは翻訳せずそのまま維持する
- `README.md` 冒頭に `[日本語版はこちら](README.ja.md)` のリンクがなければ追加する
- `README.ja.md` 冒頭に `[English version](README.md)` のリンクがなければ追加する

## 出力

`README.md` の変更に対応する `README.ja.md` の差分（または全文）を提示し、ファイルに反映する。
