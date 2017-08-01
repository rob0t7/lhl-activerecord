require 'pry'
require 'faker'
require 'active_record'

require_relative './models/customer'

# Setup DEBUG Logging
ActiveRecord::Base.logger = Logger.new(STDOUT)

puts "Establishing DB connection..."
ActiveRecord::Base.establish_connection(
  database: 'postgresql',
  host:     'localhost',
  # username: 'username',
  # password: 'password',
  port:     5432,
  pool:     5,
  encoding: 'unicode'
)
puts "Connected"

puts "Setting up DB Schema..."
ActiveRecord::Schema.define do
  drop_table :customers, cascade: true, if_exists: true

  create_table :customers do |t|
    t.string :name,  null: false
    t.string :email, null: false, index: true, unique: true
    t.date   :dob,   null: false
    t.timestamps null: false
  end
end

puts "SETUP DONE"
