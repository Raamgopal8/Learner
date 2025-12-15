class AddFirebaseFieldsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :firebase_uid, :string
    add_column :users, :provider, :string
    add_index :users, :firebase_uid, unique: true
    add_index :users, [:firebase_uid, :provider], unique: true
  end
end
