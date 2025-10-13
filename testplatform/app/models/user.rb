class User < ApplicationRecord
  belongs_to :attempt, optional: true
  belongs_to :question, optional: true
  belongs_to :option, optional: true
  has_secure_password
  has_many :attempts
end
