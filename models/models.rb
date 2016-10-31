require 'dm-core'
require 'dm-migrations'
require 'dm-postgres-adapter'

# DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")
DataMapper.setup(:default, ENV['DATABASE_URL'])

class Messages
  include DataMapper::Resource
  property :id, Serial
  property :uuid, String
  property :title, String
  property :text, String
  property :created_at, DateTime
  property :deleted_at, DateTime
end

DataMapper.finalize