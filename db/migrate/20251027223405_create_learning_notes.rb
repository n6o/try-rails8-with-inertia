class CreateLearningNotes < ActiveRecord::Migration[8.1]
  def change
    create_table :learning_notes do |t|
      t.references :student, null: false, foreign_key: { to_table: :users }
      t.references :lesson, null: false, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
