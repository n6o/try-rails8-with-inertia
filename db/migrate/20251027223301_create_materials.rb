class CreateMaterials < ActiveRecord::Migration[8.1]
  def change
    create_table :materials do |t|
      t.string :title
      t.text :description
      t.integer :material_type
      t.references :lesson, null: false, foreign_key: true

      t.timestamps
    end
  end
end
