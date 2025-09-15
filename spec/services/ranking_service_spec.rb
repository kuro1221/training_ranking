require 'rails_helper'

RSpec.describe RankingService, type: :service do
  let(:menu) { TrainingMenu.create!(name: 'menu', rule: 'rule') }
  let(:user1) { User.create!(name: 'user1', email: 'user1@example.com', password: 'secret', password_confirmation: 'secret') }
  let(:user2) { User.create!(name: 'user2', email: 'user2@example.com', password: 'secret', password_confirmation: 'secret') }
  let(:now) { Time.zone.local(2024, 6, 24, 12) }

  describe '#call' do
    it 'calculates weekly ranking' do
      TrainingRecord.create!(user: user1, training_menu: menu, count: 10, recorded_at: now)
      TrainingRecord.create!(user: user2, training_menu: menu, count: 20, recorded_at: now + 1.day)
      TrainingRecord.create!(user: user1, training_menu: menu, count: 30, recorded_at: now - 8.days)

      result = described_class.new(menu, period: 'weekly', now: now).call

      expect(result.size).to eq(2)
      expect(result.first[:user_id]).to eq(user2.id)
      expect(result.first[:total_count]).to eq(20)
    end

    it 'calculates monthly ranking excluding other months' do
      TrainingRecord.create!(user: user1, training_menu: menu, count: 15, recorded_at: now.beginning_of_month + 1.day)
      TrainingRecord.create!(user: user2, training_menu: menu, count: 5, recorded_at: now.end_of_month - 1.day)
      TrainingRecord.create!(user: user2, training_menu: menu, count: 50, recorded_at: now - 1.month)

      result = described_class.new(menu, period: 'monthly', now: now).call

      expect(result.size).to eq(2)
      expect(result.first[:user_id]).to eq(user1.id)
      expect(result.first[:total_count]).to eq(15)
    end

    it 'calculates total ranking' do
      TrainingRecord.create!(user: user1, training_menu: menu, count: 10, recorded_at: now)
      TrainingRecord.create!(user: user2, training_menu: menu, count: 20, recorded_at: now)
      TrainingRecord.create!(user: user1, training_menu: menu, count: 30, recorded_at: now - 2.months)

      result = described_class.new(menu, period: 'total', now: now).call

      expect(result.first[:user_id]).to eq(user1.id)
      expect(result.first[:total_count]).to eq(40)
    end
  end
end
