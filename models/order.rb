class Order < ActiveRecord::Base
  belongs_to :customer
  #has_and_belongs_to_many :products
  has_many :order_items
  has_many :products, through: :order_items
end
