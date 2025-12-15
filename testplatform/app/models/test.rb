class Test < ApplicationRecord
  has_many :questions, dependent: :destroy
  
  validates :title, presence: true
  validates :duration_in_minutes, presence: true, numericality: { greater_than: 0 }
end
