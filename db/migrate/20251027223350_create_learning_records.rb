class CreateLearningRecords < ActiveRecord::Migration[8.1]
  def change
    create_table :learning_records do |t|
      t.references :student, null: false, foreign_key: true
      t.references :lesson, null: false, foreign_key: true
      t.integer :duration
      t.boolean :completed
      t.datetime :completed_at

      t.timestamps
    end
  end
end
