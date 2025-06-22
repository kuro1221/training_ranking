class User < ApplicationRecord
  has_secure_password
  has_many :training_records, dependent: :destroy
end
