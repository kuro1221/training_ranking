# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies
  - 初回起動時は `bundle install` を実行して必要な gem をインストールします。

* API ドキュメント
  - `rswag` を利用して API ドキュメントを生成します。
  - `/api-docs` にアクセスすると Swagger UI で確認できます。

* Configuration
  - `/api/v1/login` に `email` と `password` を POST すると JWT が発行されます。発行されたトークンを `Authorization` ヘッダーで `Bearer <token>` として渡します。
  - API では `JWT.decode` を使ってトークンを検証し、`sub` からユーザーを取得します。

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
