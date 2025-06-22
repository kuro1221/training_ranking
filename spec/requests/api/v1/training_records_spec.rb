require 'rails_helper'

RSpec.describe "TrainingRecords API", type: :request do
  let!(:user) { User.create!(name: "tester") }
  let!(:menu) { TrainingMenu.create!(name: "エンドレス腕立て", rule: "無制限にリタイアするまで") }
  let(:token) { JWT.encode({ sub: user.id }, Rails.application.secret_key_base, 'HS256') }
  let(:headers) { { 'Authorization' => "Bearer #{token}" } }

  describe "GET /api/v1/training_menus/:id/training_records" do
    before do
      TrainingRecord.create!(user: user, training_menu: menu, count: 20, recorded_at: Time.current)
    end

    it "returns records" do
      get "/api/v1/training_menus/#{menu.id}/training_records", headers: headers
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).length).to eq(1)
    end
  end

  describe "POST /api/v1/training_menus/:id/training_records" do
    it "creates a new record" do
      post "/api/v1/training_menus/#{menu.id}/training_records", params: {
        training_record: {
          count: 30,
          recorded_at: Time.current
        }
      }, headers: headers

      expect(response).to have_http_status(:created)
      expect(TrainingRecord.count).to eq(1)
    end

    it "fails with invalid params" do
      post "/api/v1/training_menus/#{menu.id}/training_records", params: {
        training_record: {
          recorded_at: nil
        }
      }, headers: headers

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
