class CreateQuestions < ActiveRecord::Migration[8.0]
  def change
    create_table :questions do |t|
      t.integer :test_id
      t.text :question
      t.string :option_a
      t.string :option_b
      t.string :option_c
      t.string :option_d
      t.string :correct_answer

      t.timestamps
    end
  end
end
