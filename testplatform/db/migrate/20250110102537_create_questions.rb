class CreateQuestions < ActiveRecord::Migration[7.0]
    def change
      create_table :questions do |t|
        t.references :test, null: false, foreign_key: true  # automatically indexed
        t.string :question_text, null: false
        t.string :option_a
        t.string :option_b
        t.string :option_c
        t.string :option_d
        t.string :correct_option
  
        t.timestamps
      end
    end
  end  