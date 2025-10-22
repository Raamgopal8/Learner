require 'pg'

unless defined?(DB)
DB = PG.connect(
  dbname: 'testplatform',
  user: 'postgres',
  password: 'password',
  host: 'localhost',
  port: 5432
)
end