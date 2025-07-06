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
  - ユーザーには `role` があり、デフォルトでは `general` です。今後 `admin` ロールを利用して管理機能を実装予定です。
  - `rswag` を導入しており、`/api-docs` で Swagger 形式の API ドキュメントを確認できます。

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
