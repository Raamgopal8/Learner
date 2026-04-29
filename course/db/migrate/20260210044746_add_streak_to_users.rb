class AddStreakToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :streak_count, :integer
    add_column :users, :last_streak_date, :date
  end
end
