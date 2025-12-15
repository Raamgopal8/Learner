class CreateTests < ActiveRecord::Migration[8.0]
  def change
    create_table :tests do |t|
      t.string :title
      t.text :description
      t.integer :duration_in_minutes

      t.timestamps
    end
  end
end
