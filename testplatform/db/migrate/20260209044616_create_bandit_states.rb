class CreateBanditStates < ActiveRecord::Migration[8.0]
  def change
    create_table :bandit_states do |t|
      t.integer :course_id
      t.integer :d
      t.json :A
      t.json :b
      t.timestamp :last_update

      t.timestamps
    end
  end
end
