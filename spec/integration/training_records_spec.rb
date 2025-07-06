require 'swagger_helper'

RSpec.describe 'TrainingRecords API', type: :request do
  path '/api/v1/training_menus/{training_menu_id}/training_records' do
    get '記録一覧' do
      tags 'TrainingRecords'
      produces 'application/json'
      parameter name: :training_menu_id, in: :path, type: :string
      security [ bearerAuth: [] ]

      response '200', 'ok' do
        let(:training_menu_id) { TrainingMenu.create!(name: 'menu', rule: 'rule').id }
        let(:Authorization) do
          user = User.create!(name: 'tester', email: 'tester@example.com', password: 'secret', password_confirmation: 'secret')
          token = JWT.encode({ sub: user.id }, Rails.application.secret_key_base, 'HS256')
          "Bearer #{token}"
        end
        run_test!
      end
    end

    post '記録作成' do
      tags 'TrainingRecords'
      consumes 'application/json'
      parameter name: :training_menu_id, in: :path, type: :string
      parameter name: :training_record, in: :body, schema: {
        type: :object,
        properties: {
          count: { type: :integer },
          recorded_at: { type: :string, format: 'date-time' }
        },
        required: %w[count recorded_at]
      }
      security [ bearerAuth: [] ]

      response '201', 'created' do
        let(:training_menu_id) { TrainingMenu.create!(name: 'menu', rule: 'rule').id }
        let(:training_record) { { count: 10, recorded_at: Time.current } }
        let(:Authorization) do
          user = User.create!(name: 'tester', email: 'tester@example.com', password: 'secret', password_confirmation: 'secret')
          token = JWT.encode({ sub: user.id }, Rails.application.secret_key_base, 'HS256')
          "Bearer #{token}"
        end
        run_test!
      end

      response '422', 'invalid' do
        let(:training_menu_id) { TrainingMenu.create!(name: 'menu', rule: 'rule').id }
        let(:training_record) { { recorded_at: nil } }
        let(:Authorization) do
          user = User.create!(name: 'tester', email: 'tester@example.com', password: 'secret', password_confirmation: 'secret')
          token = JWT.encode({ sub: user.id }, Rails.application.secret_key_base, 'HS256')
          "Bearer #{token}"
        end
        run_test!
      end
    end
  end
end
