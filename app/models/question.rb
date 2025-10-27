class Question < ApplicationRecord
  belongs_to :lesson

  has_many :test_results, dependent: :destroy

  # Question types: multiple_choice(0), true_false(1), short_answer(2), essay(3)
  enum :question_type, { multiple_choice: 0, true_false: 1, short_answer: 2, essay: 3 }

  validates :content, presence: true
  validates :question_type, presence: true
end
