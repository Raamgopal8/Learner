class Course < ApplicationRecord
  has_many :bandit_states, dependent: :destroy
  has_many :bandit_rewards, dependent: :destroy
  
  validates :title, presence: true
  validates :category, presence: true
end
