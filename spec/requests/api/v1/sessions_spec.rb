require 'rails_helper'

RSpec.describe 'Sessions API', type: :request do
  let!(:user) do
    User.create!(name: 'tester', password: 'secret', password_confirmation: 'secret')
  end

  it 'returns token with valid credentials' do
    post '/api/v1/login', params: { name: 'tester', password: 'secret' }
    expect(response).to have_http_status(:created)
    expect(JSON.parse(response.body)).to have_key('token')
  end

  it 'returns unauthorized with wrong password' do
    post '/api/v1/login', params: { name: 'tester', password: 'wrong' }
    expect(response).to have_http_status(:unauthorized)
  end
end
