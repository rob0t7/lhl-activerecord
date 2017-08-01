require 'pry'
require 'faker'
require 'active_record'

require_relative './models/customer'
require_relative './models/product'
require_relative './models/order'
require_relative './models/order_item'

# Setup DEBUG Logging
ActiveRecord::Base.logger = Logger.new(STDOUT)

puts "Establishing DB connection..."
ActiveRecord::Base.establish_connection(
  adapter:  'postgresql',
  database: 'activerecord-lhl',
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
  drop_table :products, cascade: true, if_exists: true
  drop_table :orders, cascade: true, if_exists: true
  drop_table :orders_products, if_exists: true
  drop_table :order_items, if_exists: true

  create_table :customers do |t|
    t.string :name,  null: false
    t.string :email, null: false, index: true, unique: true
    t.date   :dob,   null: false
    t.timestamps null: false
  end

  create_table :products do |t|
    t.string :name
    t.integer :inventory, default: 1
    t.text :description
    t.integer :price_cents, default: 0
    t.timestamps null: false
  end

  create_table :orders do |t|
    t.datetime :order_date
    t.string :street_address
    t.string :city
    t.string :province
    t.string :country
    t.string :postal_code

    t.references :customer, index: true, foreign: true
    #t.belongs_to :customer, index: true, foreign: true
    #t.integer :customer_id, index: true

    t.timestamps null: false
  end

  # create_table :orders_products, id: false do |t|
  #   t.references :order
  #   t.references :product
  # end
  # add_index(:orders_products, [:order_id, :product_id])
  #create_join_table :orders, :products

  create_table :order_items do |t|
    t.integer :price_cents, default: 0
    t.references :order
    t.references :product
    t.integer :quantity, default: 1
    t.timestamps
  end
end

puts 'SEED THE DB'

product = Product.create!(
  name: 'Product 1',
  description: 'This is the product description',
  price_cents: 10000
)
1.upto(10) do
  customer = Customer.create(name: Faker::Name.name, email: Faker::Internet.email, dob: '1900-01-01')
  1.upto(5) do
    order = customer.orders.create!(
      street_address: '123 Some St',
      city: 'Toronto',
      order_date: Date.today
    )
    order.order_items.create!(product: product, price_cents: 1000, quantity: rand(10))
  end

end


puts "SETUP DONE"
