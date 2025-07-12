# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies
  - 初回起動時は `bundle install` を実行して必要な gem をインストールします。

* Configuration
  - `/api/v1/login` に `email` と `password` を POST すると JWT が発行されます。発行されたトークンを `Authorization` ヘッダーで `Bearer <token>` として渡します。
  - API では `JWT.decode` を使ってトークンを検証し、`sub` からユーザーを取得します。

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## API ドキュメント

このリポジトリでは `rswag` を利用して Swagger 形式の API ドキュメントを生成しています。
GitHub Actions の `Update Swagger Docs` ワークフローにより `main` ブランチへ push するとドキュメントが生成され、`gh-pages` ブランチへデプロイされます。
GitHub Pages の設定を有効にするとブラウザから `/api-docs` または GitHub Pages 上で確認できます。
