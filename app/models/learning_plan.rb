class LearningPlan < ApplicationRecord
  belongs_to :student, class_name: "User"
  belongs_to :lesson

  validates :scheduled_at, presence: true

  scope :upcoming, -> { where("scheduled_at >= ?", Time.current).order(:scheduled_at) }
  scope :completed, -> { where(completed: true) }
  scope :pending, -> { where(completed: false) }
end
