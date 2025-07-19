require 'swagger_helper'

RSpec.describe 'Users API', swagger_doc: 'v1/swagger.yaml', type: :request do
  path '/api/v1/users' do
    post 'ユーザー登録' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          email: { type: :string },
          password: { type: :string },
          password_confirmation: { type: :string }
        },
        required: %w[name email password password_confirmation]
      }

      response(201, '作成成功') do
        let(:user) { { user: { name: 'tester', email: 'tester@example.com', password: 'secret', password_confirmation: 'secret' } } }
        run_test! do |response|
          expect(User.last.role).to eq(1)
        end
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
      end

      response(422, '不正なパラメータ') do
        let(:user) { { user: { name: '' } } }
        run_test!
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
      end
    end
  end
end
