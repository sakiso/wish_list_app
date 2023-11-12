# 前提事項
Flutterのバージョン管理ツールとして`fvm`を利用する

# セットアップ
- 当リポジトリをclone
- プロジェクトルートで`fvm install`を実行し、Flutterのバージョンを合わせる
  - Flutterのコマンドを使うときは先頭に`fvm`を追加する。`fvm flutter doctor`など。

# Isar設定ファイル生成方法
データのローカルDBでの永続化のために`Isar`を利用している。  
モデルを新規作成・修正した場合、Isarに必要な各種アノテーション等を記述してから
`fvm flutter pub run build_runner build`でIsar用の設定ファイルを生成すること。
