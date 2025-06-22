require 'bcrypt'

class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  has_many :training_records, dependent: :destroy
end
