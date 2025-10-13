class CreateTests < ActiveRecord::Migration[7.0]
  def change
    create_table :tests do |t|
      t.string :title, null: false
      t.text :description
      t.integer :duration_minutes, default: 30
      t.integer :total_questions, default: 0
      t.boolean :published, default: false
      t.datetime :published_at
      t.references :created_by, foreign_key: { to_table: :users }
      t.timestamps
    end

  end
end