class CreateTestCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :test_categories do |t|
      t.references :test, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.timestamps
    end
  
  end
end