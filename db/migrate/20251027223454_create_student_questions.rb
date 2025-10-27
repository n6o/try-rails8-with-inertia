class CreateStudentQuestions < ActiveRecord::Migration[8.1]
  def change
    create_table :student_questions do |t|
      t.references :student, null: false, foreign_key: { to_table: :users }
      t.references :lesson, null: false, foreign_key: true
      t.text :question
      t.text :answer
      t.datetime :answered_at

      t.timestamps
    end
  end
end
