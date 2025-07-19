require 'swagger_helper'

RSpec.describe "TrainingRecords API", swagger_doc: 'v1/swagger.yaml', type: :request do
  let!(:user) { User.create!(name: "tester", email: "tester@example.com", password: "secret", password_confirmation: "secret") }
  let!(:menu) { TrainingMenu.create!(name: "エンドレス腕立て", rule: "無制限にリタイアするまで") }
  let(:token) { JWT.encode({ sub: user.id }, Rails.application.secret_key_base, 'HS256') }
  let(:headers) { { 'Authorization' => "Bearer #{token}" } }

  path "/api/v1/training_menus/{training_menu_id}/training_records" do
    parameter name: :training_menu_id, in: :path, type: :string, description: 'メニューID'
    parameter name: :Authorization, in: :header, type: :string, required: false

    get "一覧取得" do
      tags "TrainingRecords"
      produces "application/json"

      response(200, "成功") do
        let(:training_menu_id) { menu.id }
        let(:Authorization) { "Bearer #{token}" }
        before do
          TrainingRecord.create!(user: user, training_menu: menu, count: 20, recorded_at: Time.current)
        end
        run_test! do |response|
          expect(JSON.parse(response.body).length).to eq(1)
        end
        after do |example|
          example.metadata[:response][:content] = {
            "application/json" => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
      end

      response(401, "未認証") do
        let(:training_menu_id) { menu.id }
        run_test!
      end
    end

    post "登録" do
      tags "TrainingRecords"
      consumes "application/json"
      produces "application/json"

      parameter name: :training_record, in: :body, schema: {
        type: :object,
        properties: {
          count: { type: :integer },
          recorded_at: { type: :string, format: :date_time }
        },
        required: %w[count recorded_at]
      }

      response(201, "作成成功") do
        let(:training_menu_id) { menu.id }
        let(:Authorization) { "Bearer #{token}" }
        let(:training_record) { { count: 30, recorded_at: Time.current } }
        run_test! do |response|
          expect(TrainingRecord.count).to eq(1)
        end
        after do |example|
          example.metadata[:response][:content] = {
            "application/json" => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
      end

      response(422, "不正なパラメータ") do
        let(:training_menu_id) { menu.id }
        let(:Authorization) { "Bearer #{token}" }
        let(:training_record) { { recorded_at: nil } }
        run_test!
        after do |example|
          example.metadata[:response][:content] = {
            "application/json" => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
      end

      response(401, "未認証") do
        let(:training_menu_id) { menu.id }
        let(:training_record) { { count: 10, recorded_at: Time.current } }
        run_test!
        after do |example|
          example.metadata[:response][:content] = {
            "application/json" => {
              example: response.body.presence
            }
          }
        end
      end
    end
  end
end
