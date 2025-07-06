require 'bcrypt'

class User < ApplicationRecord
  has_secure_password
  enum role: { admin: 0, general: 1 }
  validates :email, presence: true, uniqueness: true
  has_many :training_records, dependent: :destroy
end
