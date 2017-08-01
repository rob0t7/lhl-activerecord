class Customer < ActiveRecord::Base
  # validations
  validates :name, presence: true
  validates :dob,  presence: true
  validates :email,
            presence: true,
            format: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i,
            uniqueness: true

  # callbacks
  before_validation { self.email = email.downcase }
end
