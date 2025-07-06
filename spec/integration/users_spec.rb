require 'swagger_helper'

RSpec.describe 'Users API', swagger_doc: 'v1/swagger.yaml' do
  path '/api/v1/users' do
    post 'ユーザーを作成' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          email: { type: :string },
          password: { type: :string },
          password_confirmation: { type: :string },
          role: { type: :string, enum: %w[admin general] }
        },
        required: %w[name email password password_confirmation]
      }

      response 201, 'created' do
        let(:user) do
          {
            name: 'tester',
            email: 'tester@example.com',
            password: 'secret',
            password_confirmation: 'secret'
          }
        end
        run_test!
      end

      response 422, 'invalid request' do
        let(:user) { { name: '' } }
        run_test!
      end
    end
  end
end
