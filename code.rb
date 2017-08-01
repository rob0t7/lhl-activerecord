require 'active_record'
require 'faker'

ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  database: 'activerecord-lhl',
  username: 'rob',
  host: 'localhost'
)
ActiveRecord::Base.logger = Logger.new(STDOUT)

ActiveRecord::Schema.define do
  drop_table :customers if ActiveRecord::Base.connection.table_exists? :customers

  create_table :customers do |table|
    table.string :name, null: false
    table.string :email, null: false, index: true, unique: true
    table.date :dob, null: false
    table.timestamps null: false
  end
end


class Customer < ActiveRecord::Base
  validates :name, presence: true
  validates :email, presence: true,
                     uniqueness: true,
                     format: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i


  before_validation { self.email = email.downcase }

  def self.find_by_email(email)
    find_by(email: email.downcase)
  end
end

# Seed
1.upto(50) do
  Customer.create(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    dob: Faker::Date.between(100.years.ago, Date.current)
  )
end

bob = Customer.new(
  name: 'Bob Smith',
  email: 'bob@example.com',
  dob: '1950-02-12'
)
puts "Is bob persisted: #{bob.persisted?}"
puts "Is bob new: #{bob.new_record?}"

bob.save

Customer.create!(
  name: 'Jill',
  email: 'Jill@example.com',
  dob: 2.years.ago
)

# Queries
Customer.all # find all the customers

Customer.order(name: :desc)
jill = Customer.find_by(email: 'Jill@example.com')
jill = Customer.find_by_email('Jill@example.com')
jill = Customer.find(3) # find by primary key

jill = Customer.where(email: 'Jill@example.com')

Customer.where('dob > ?', 19.years.ago)
Customer.where('dob > :age', age: 19.years.ago).order(:name)
# Update

Customer.where('dob > :age', age: 19.years.ago).each do |customer|
  # customer.name = 'bob'
  # customer.save
  customer.update(name: 'bob')
end

# Destroy
random_customer = Customer.order(:name)[3]
random_customer.destroy #use this one
random_customer.delete
