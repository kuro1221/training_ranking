require 'swagger_helper'

RSpec.describe "Rankings API", swagger_doc: 'v1/swagger.yaml', type: :request do
  let!(:user1) { User.create!(name: "user1", email: "user1@example.com", password: "secret", password_confirmation: "secret") }
  let!(:user2) { User.create!(name: "user2", email: "user2@example.com", password: "secret", password_confirmation: "secret") }
  let!(:menu) { TrainingMenu.create!(name: "menu", rule: "rule") }
  let(:token) { JWT.encode({ sub: user1.id }, Rails.application.secret_key_base, 'HS256') }
  let(:headers) { { 'Authorization' => "Bearer #{token}" } }

  path "/api/v1/training_menus/{training_menu_id}/rankings" do
    parameter name: :training_menu_id, in: :path, type: :string, description: 'メニューID'
    parameter name: :period, in: :query, type: :string, required: false, description: 'weekly, monthly, total'
    parameter name: :Authorization, in: :header, type: :string, required: false

    get "ランキング取得" do
      tags "Rankings"
      produces "application/json"

      response(200, "成功") do
        let(:training_menu_id) { menu.id }
        let(:period) { 'total' }
        let(:Authorization) { "Bearer #{token}" }
        before do
          TrainingRecord.create!(user: user1, training_menu: menu, count: 10, recorded_at: Time.current)
          TrainingRecord.create!(user: user2, training_menu: menu, count: 20, recorded_at: Time.current)
        end
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data.first['user_id']).to eq(user2.id)
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
