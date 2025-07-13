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
        run_test! do
          expect(User.last.role).to eq(1)
        end
      end

      response(422, '不正なパラメータ') do
        let(:user) { { user: { name: '' } } }
        run_test!
      end
    end
  end
end
