require 'swagger_helper'

RSpec.describe 'Sessions API', swagger_doc: 'v1/swagger.yaml', type: :request do
  let!(:user) do
    User.create!(name: 'tester', email: 'tester@example.com', password: 'secret', password_confirmation: 'secret')
  end

  path '/api/v1/login' do
    post 'ログイン' do
      tags 'Sessions'
      consumes 'application/json'
      parameter name: :credentials, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[email password]
      }

      response(201, '成功') do
        let(:credentials) { { email: 'tester@example.com', password: 'secret' } }
        run_test! do |response|
          expect(JSON.parse(response.body)).to have_key('token')
        end
      end

      response(401, '認証失敗') do
        let(:credentials) { { email: 'tester@example.com', password: 'wrong' } }
        run_test!
      end
    end
  end
end
