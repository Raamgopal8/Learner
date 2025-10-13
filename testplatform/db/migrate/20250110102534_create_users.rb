class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :first_name
      t.string :last_name
      t.string :role, default: 'student'
      t.boolean :active, default: true
      t.timestamps
    end
   
  end
end