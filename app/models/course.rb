class Course < ApplicationRecord
  belongs_to :teacher, class_name: "User"

  has_many :lessons, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
end
