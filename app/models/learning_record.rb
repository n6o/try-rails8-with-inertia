class LearningRecord < ApplicationRecord
  belongs_to :student, class_name: "User"
  belongs_to :lesson

  validates :duration, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
end
