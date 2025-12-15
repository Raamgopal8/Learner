class AddContentFieldsToCourses < ActiveRecord::Migration[8.0]
  def change
    add_column :courses, :syllabus, :jsonb, default: {}
    add_column :courses, :content, :text
    add_column :courses, :learning_outcomes, :text, array: true, default: []
  end
end
