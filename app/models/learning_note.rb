class LearningNote < ApplicationRecord
  belongs_to :student, class_name: "User"
  belongs_to :lesson

  validates :content, presence: true
end
