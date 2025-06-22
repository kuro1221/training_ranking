# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration
  - API では `Authorization` ヘッダーに JWT を渡します。JWT は `HS256` 方式で署名されている想定で、`sub` クレームにユーザー ID を含めます。
  - コントローラでは `JWT.decode` を使ってトークンを検証し、`sub` からユーザーを取得します。

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
