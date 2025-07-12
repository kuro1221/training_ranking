require 'rails_helper'

RSpec.describe 'API Docs', type: :request do
  it 'serves the swagger UI' do
    get '/api-docs'
    expect([ 200, 301, 302 ]).to include(response.status)
  end
end
