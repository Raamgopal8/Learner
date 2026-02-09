# Add missing timestamps to attempts table
ActiveRecord::Base.connection.execute("ALTER TABLE attempts ADD COLUMN created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP")
ActiveRecord::Base.connection.execute("ALTER TABLE attempts ADD COLUMN updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP")
puts "Added created_at and updated_at columns to attempts table"
