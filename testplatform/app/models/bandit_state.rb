class BanditState < ApplicationRecord
  belongs_to :course
  
  validates :course_id, presence: true
  validates :d, presence: true
  validates :A, presence: true
  validates :b, presence: true
end
