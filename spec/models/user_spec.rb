require 'rails_helper'

RSpec.describe User, type: :model do
  it 'デフォルトで一般ユーザーになる' do
    user = User.create!(name: 'tester', email: 'tester@example.com', password: 'secret', password_confirmation: 'secret')
    expect(user.role).to eq('general')
    expect(user.general?).to be true
  end

  it '管理者ロールを設定できる' do
    admin = User.create!(name: 'admin', email: 'admin@example.com', password: 'secret', password_confirmation: 'secret', role: :admin)
    expect(admin.admin?).to be true
  end
end
