class User < ApplicationRecord
  # Basic user model without authentication
  validates :email, presence: true, uniqueness: true
end
