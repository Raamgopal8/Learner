class AddCategoryToTests < ActiveRecord::Migration[8.0]
  def change
    add_column :tests, :category, :string
  end
end
