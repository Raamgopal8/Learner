class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.string :instructor, null: false
      t.integer :duration, null: false  # in hours
      t.decimal :price, null: false, precision: 10, scale: 2
      t.string :level, null: false     # Beginner, Intermediate, Advanced
      t.string :category, null: false
      t.boolean :featured, default: false
      t.decimal :rating, precision: 2, scale: 1, default: 0.0
      t.integer :reviews_count, default: 0
      t.text :course_icon
      t.timestamps
    end

    add_index :courses, :category
    add_index :courses, :level
    add_index :courses, :featured
  end
end
