class CreateQuestions < ActiveRecord::Migration[8.1]
  def change
    create_table :questions do |t|
      t.text :content
      t.integer :question_type
      t.references :lesson, null: false, foreign_key: true
      t.text :correct_answer

      t.timestamps
    end
  end
end
