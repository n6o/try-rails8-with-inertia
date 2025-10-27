class CreateLearningPlans < ActiveRecord::Migration[8.1]
  def change
    create_table :learning_plans do |t|
      t.references :student, null: false, foreign_key: { to_table: :users }
      t.references :lesson, null: false, foreign_key: true
      t.datetime :scheduled_at
      t.boolean :completed

      t.timestamps
    end
  end
end
