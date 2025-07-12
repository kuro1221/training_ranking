require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'is valid with name, email and password' do
      user = User.new(name: 'tester', email: 'test@example.com', password: 'secret', password_confirmation: 'secret')
      expect(user).to be_valid
    end

    it 'is invalid without email' do
      user = User.new(name: 'tester', email: nil, password: 'secret', password_confirmation: 'secret')
      expect(user).not_to be_valid
    end

    it 'enforces unique email' do
      User.create!(name: 'tester1', email: 'dup@example.com', password: 'secret', password_confirmation: 'secret')
      user = User.new(name: 'tester2', email: 'dup@example.com', password: 'secret', password_confirmation: 'secret')
      expect(user).not_to be_valid
    end
  end
end
