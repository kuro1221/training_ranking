require 'rails_helper'

RSpec.describe 'API Docs routing', type: :routing do
  it 'routes /api-docs to rswag' do
    paths = Rails.application.routes.routes.map { |r| r.path.spec.to_s }
    expect(paths).to include('/api-docs')
  end
end
