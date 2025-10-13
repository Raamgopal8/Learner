class Answer < ApplicationRecord
  belongs_to :attempt, optional: true
  belongs_to :question, optional: true
  belongs_to :option, optional: true
end
