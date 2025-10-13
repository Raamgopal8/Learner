class CreateResponses < ActiveRecord::Migration[7.0]
  def change
    create_table :responses do |t|
      t.references :attempt, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.references :option, foreign_key: true
      t.text :answer_text # For text-based answers
      t.boolean :is_correct
      t.integer :points_earned, default: 0
      t.timestamps
    end
   
  end
end
