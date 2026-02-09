class CreateBanditRewards < ActiveRecord::Migration[8.0]
  def change
    create_table :bandit_rewards do |t|
      t.integer :user_id
      t.integer :course_id
      t.float :reward
      t.json :context

      t.timestamps
    end
  end
end
