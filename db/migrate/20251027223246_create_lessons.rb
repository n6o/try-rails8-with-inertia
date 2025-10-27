class CreateLessons < ActiveRecord::Migration[8.1]
  def change
    create_table :lessons do |t|
      t.string :title
      t.text :description
      t.text :content
      t.references :course, null: false, foreign_key: true
      t.integer :order_index

      t.timestamps
    end
  end
end
