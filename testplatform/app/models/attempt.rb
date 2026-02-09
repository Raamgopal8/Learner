class Attempt < ApplicationRecord
  belongs_to :user
  belongs_to :test
  
  validates :user_id, presence: true
  validates :test_id, presence: true
  validates :score, presence: true
  validates :total_points, presence: true
end
