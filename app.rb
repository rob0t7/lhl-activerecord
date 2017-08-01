require_relative './setup'

# Create a Model

bob = Customer.new(name: 'Bob', email: 'bob@example.com', dob: '1980-03-21')
bob.save # returns true or false depending on success
bobe.save! # same as above but throws exception on failure

jill = Customer.create(name: 'Jill', email: 'jill@example.com', dob: Date.new(2000, 2, 10))
# careful with the version above since it can hide errors since it always returns a truthy value

# Query and Fetch a Model
customer = Customer.find(1) # find by primary key
customer = Customer.find_by(email: 'bob@example.com') # returns 1 object
customer = Customer.find_by_email('bob@example.com') # same as above using 'rails' magic

customers = Customer.where(name: 'Bob') # find all the Bobs, returns an array like object
customers = Customer.where('dob < :age', age: '1990-01-01')

# Update a model

customer = Customer.find_by_email('jill@example.com')
customer.name = 'John'
customer.save # Does an update call

# or

customer.update(name: 'Jill') # does both modification and save

## Remove an object
customer.destroy
