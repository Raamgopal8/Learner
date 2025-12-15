class Question < ApplicationRecord
  belongs_to :test
  
  validates :question, presence: true
  validates :option_a, :option_b, :option_c, :option_d, presence: true
  validates :correct_answer, presence: true, inclusion: { in: ['A', 'B', 'C', 'D'] }
end
