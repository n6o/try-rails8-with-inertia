class CreateTestResults < ActiveRecord::Migration[8.1]
  def change
    create_table :test_results do |t|
      t.references :student, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.text :answer
      t.boolean :correct
      t.integer :score

      t.timestamps
    end
  end
end
