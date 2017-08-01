class Product < ActiveRecord::Base
  #has_and_belongs_to_many :orders
  has_many :order_items
  has_many :orders, through: :order_items

  validates :name, presence: true
  validates :inventory, numericality: {greater_than_or_equal: 0}
end
