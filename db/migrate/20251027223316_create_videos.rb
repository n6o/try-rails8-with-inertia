class CreateVideos < ActiveRecord::Migration[8.1]
  def change
    create_table :videos do |t|
      t.string :title
      t.text :description
      t.integer :duration
      t.references :lesson, null: false, foreign_key: true

      t.timestamps
    end
  end
end
