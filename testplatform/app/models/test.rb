class Test < ApplicationRecord
  belongs_to :attempt
  belongs_to :question
  belongs_to :option
  has_many :questions, -> { order(:position) }, dependent: :destroy

  # Add this:
  belongs_to :created_by, class_name: 'User', optional: true
end
