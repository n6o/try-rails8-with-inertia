class StudentQuestion < ApplicationRecord
  belongs_to :student, class_name: "User"
  belongs_to :lesson

  validates :question, presence: true

  scope :answered, -> { where.not(answered_at: nil) }
  scope :unanswered, -> { where(answered_at: nil) }
end
