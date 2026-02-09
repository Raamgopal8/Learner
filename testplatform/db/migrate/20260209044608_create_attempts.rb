class CreateAttempts < ActiveRecord::Migration[8.0]
  def change
    create_table :attempts do |t|
      t.integer :user_id
      t.integer :test_id
      t.integer :score
      t.integer :total_points
      t.timestamp :submitted_at

      t.timestamps
    end
  end
end
