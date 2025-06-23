require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  describe 'POST /api/v1/users' do
    it 'creates a new user with valid params' do
      expect do
        post '/api/v1/users', params: {
          user: {
            name: 'tester',
            email: 'tester@example.com',
            password: 'secret',
            password_confirmation: 'secret'
          }
        }
      end.to change(User, :count).by(1)
      expect(response).to have_http_status(:created)
    end

    it 'returns errors with invalid params' do
      post '/api/v1/users', params: { user: { name: '' } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
