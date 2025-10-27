class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Role enum: student(0), teacher(1), admin(2)
  enum :role, { student: 0, teacher: 1, admin: 2 }

  # Associations
  # Teacher associations
  has_many :taught_courses, class_name: "Course", foreign_key: "teacher_id", dependent: :destroy

  # Student associations
  has_many :learning_records, foreign_key: "student_id", dependent: :destroy
  has_many :learning_notes, foreign_key: "student_id", dependent: :destroy
  has_many :test_results, foreign_key: "student_id", dependent: :destroy
  has_many :learning_plans, foreign_key: "student_id", dependent: :destroy
  has_many :student_questions, foreign_key: "student_id", dependent: :destroy

  # Validations
  validates :name, presence: true
  validates :role, presence: true
end
