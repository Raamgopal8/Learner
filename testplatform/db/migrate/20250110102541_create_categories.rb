class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.text :description
      t.string :color, default: '#3498db'
      t.integer :position, default: 0
      t.boolean :active, default: true
      t.timestamps
    end
  
  end
end
