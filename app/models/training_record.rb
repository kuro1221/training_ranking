class TrainingRecord < ApplicationRecord
  belongs_to :user
  belongs_to :training_menu

  validates :count, presence: false, numericality: { only_integer: true, greater_than: 0 }
  validates :recorded_at, presence: true
end
