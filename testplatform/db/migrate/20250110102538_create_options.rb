class CreateOptions < ActiveRecord::Migration[7.0]
  def change
    create_table :options do |t|
      t.references :question, null: false, foreign_key: true
      t.text :content, null: false
      t.boolean :is_correct, default: false
      t.integer :position, null: false
      t.timestamps
    end
   
  end
end
