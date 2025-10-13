class CreateAttempts < ActiveRecord::Migration[7.0]
  def change
    create_table :attempts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :test, null: false, foreign_key: true
      t.datetime :started_at
      t.datetime :submitted_at
      t.integer :score, default: 0
      t.integer :total_points, default: 0
      t.string :status, default: 'in_progress' # in_progress, completed, timed_out
      t.integer :time_taken_seconds
      t.timestamps
    end
    
  end
end
