require 'rails_helper'

RSpec.describe TrainingMenu, type: :model do
  it 'has many training_records' do
    assoc = described_class.reflect_on_association(:training_records)
    expect(assoc.macro).to eq(:has_many)
  end
end
