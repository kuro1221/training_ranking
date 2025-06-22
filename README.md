# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration
  - `/api/v1/login` に `name` と `password` を POST すると JWT が発行されます。発行されたトークンを `Authorization` ヘッダーで `Bearer <token>` として渡します。
  - API では `JWT.decode` を使ってトークンを検証し、`sub` からユーザーを取得します。

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
