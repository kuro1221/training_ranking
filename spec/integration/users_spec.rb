require 'swagger_helper'

RSpec.describe 'Users API', type: :request do
  path '/api/v1/users' do
    post 'ユーザー作成' do
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

      response '201', 'created' do
        let(:user) { { name: 'tester', email: 'tester@example.com', password: 'secret', password_confirmation: 'secret' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:user) { { name: '' } }
        run_test!
      end
    end
  end
end
