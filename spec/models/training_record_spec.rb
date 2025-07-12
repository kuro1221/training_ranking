require 'rails_helper'

RSpec.describe TrainingRecord, type: :model do
  let(:user) { User.create!(name: 'tester', email: 'tester@example.com', password: 'secret', password_confirmation: 'secret') }
  let(:menu) { TrainingMenu.create!(name: 'menu', rule: 'rule') }

  it 'is valid with count and recorded_at' do
    record = described_class.new(user: user, training_menu: menu, count: 10, recorded_at: Time.current)
    expect(record).to be_valid
  end

  it 'is invalid without recorded_at' do
    record = described_class.new(user: user, training_menu: menu, count: 10, recorded_at: nil)
    expect(record).not_to be_valid
  end

  it 'rejects non positive counts' do
    record = described_class.new(user: user, training_menu: menu, count: -1, recorded_at: Time.current)
    expect(record).not_to be_valid
  end
end
