class AddPerformanceIndexes < ActiveRecord::Migration[8.0]
  def change
    # Add indexes for common queries to improve performance
    add_index :users, :email, unique: true if index_exists?(:users, :email) == false
    add_index :users, :username, unique: true if index_exists?(:users, :username) == false
    add_index :users, :created_at
    add_index :users, :updated_at
    
    # Add composite indexes for complex queries
    add_index :users, [:firebase_uid, :provider], unique: true if index_exists?(:users, [:firebase_uid, :provider]) == false
    
    # Add indexes for courses table if it exists
    if table_exists?(:courses)
      add_index :courses, :created_at
      add_index :courses, :updated_at
      add_index :courses, :title
      # Only add published index if column exists
      add_index :courses, :published if column_exists?(:courses, :published)
    end
    
    # Add indexes for enrollments table if it exists
    if table_exists?(:enrollments)
      add_index :enrollments, :user_id if index_exists?(:enrollments, :user_id) == false
      add_index :enrollments, :course_id if index_exists?(:enrollments, :course_id) == false
      add_index :enrollments, :created_at if index_exists?(:enrollments, :created_at) == false
      add_index :enrollments, [:user_id, :course_id], unique: true if index_exists?(:enrollments, [:user_id, :course_id]) == false
    end
  end
end
