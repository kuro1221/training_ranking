require 'swagger_helper'

RSpec.describe 'Sessions API', type: :request do
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

      response '201', 'created' do
        let!(:user) { User.create!(name: 'tester', email: 'tester@example.com', password: 'secret', password_confirmation: 'secret') }
        let(:credentials) { { email: user.email, password: 'secret' } }
        run_test!
      end

      response '401', 'unauthorized' do
        let(:credentials) { { email: 'tester@example.com', password: 'wrong' } }
        run_test!
      end
    end
  end
end
