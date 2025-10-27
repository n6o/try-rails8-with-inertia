class Lesson < ApplicationRecord
  belongs_to :course

  has_many :materials, dependent: :destroy
  has_many :videos, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :learning_records, dependent: :destroy
  has_many :learning_notes, dependent: :destroy
  has_many :learning_plans, dependent: :destroy
  has_many :student_questions, dependent: :destroy

  validates :title, presence: true
  validates :order_index, presence: true, numericality: { only_integer: true }
end
