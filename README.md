# ActiveRecord and OOP Intro

Here's a summary of what we talked about.

## Review of OOP

We briefly went over some common mistakes students make when working
with OOP in ruby.

## RubyGems and Bundler

Ruby libraries are called gems. Gems are similar to npm packages in
JS. You can install and manage your *system* gems using the **gem**
command.

*gem* however is system wide (see npm install -global), which does not
help us with project based dependencies. For that role we have another
tool called **Bundler**.

Bundler helps us manage which libraries/dependencies we use in our
project similar to *package.json*. It also helps us manage the correct versions of our
dependencies. We specify our dependencies in a special file called
*GemFile*. We can then run **bundle install** to download and install
the packages. This in turn creates a special file that *pins* packages
to a special version. See Gemfile.lock.

## ActiveRecord

It is an ORM, an Object Relational Mapper. What is an ORM?

Heads up:

It going to seem like a bunch of magic
You will want to read the guide / documentation and it will take time to recall the API.
Basically there's a lot of meta programming to help us write VERY LITTLE code.

What does AR give us?
* OOP paradigm to deal with our data
* Class methods and instance methods
* Query builder
* Returns to us instances of our Domain model (BlogPost)
* CRUD methods to do SELECT / DELETE / etc against our tables.
* Associations between models (belongsto and hasmany). DO NOT get caught up with hasandbelongstomany.
* Data Validations
* Work with rows as though they are instances with attributes

The "mapping"
* Table -> Class / Model (eg: User)
* Row -> Instance of Class
* Col -> Attribute on Instance

**Important Rule for Rails & ActiveRecord:**

"Convention over Configuration" therefore if you follow the general
rules, it can make accurate assumptions. The Naming conventions are
only important if you want to use the defaults / conventions (and
write less code)

## Demo Code

See (https://github.com/rob0t7/lhl-activerecord

To run the code
``` shell
bundle install
ruby app
```

## Breakout Lesson

During our breakout we looked at how to set up relationships between
objects. We specifically looked at the following items:

* 1-to-many relationships
* many-to-many relationships
* how to retrieve and create models using these relationships
* Prefetch records (the N+1 problem)

### Active Record Relationships

In order to create a relationship between two DB backed objects we
have to do two things. 1) Setup the relationship info on the models
themselves, and 2) add the references to the database schema.

The sample code has many examples on how to create the different
relationships. Please check it out.

To create a many-to-many relationship there exists a few extra steps,
depending on whether you want a pure join table or 1 with extra
information.

For a pure join table you need to do the following:

1. Add *belongs_and_has_many to the models
2. Create a join table (using *create_join_table* for Rails >5.0 or
   manually with create_table) were the name of the table is the name
   of the two models in alphabetical order. Example Orders <=>
   Products would have a orders_products table.

If you are not using a pure join you will have to create a table and
model similar to the example code. See OrderItem model.

### Prefetch Data

When we are returning JSON/HTML for a summary page (thing GET index)
we tend to fetch a bunch of records, then in a loop for each record
fetch all the corresponding records. This leads to the N+1 problem
where we are overloaded with DB calls.

Here is some sample code

``` ruby
Order.all.each do |order|
  puts "Order #{order.id} has the following products:"
  order.order_items.each do |order_item|
    puts order_item.product.name
  end
end
```

The above function is really bad for performance since it does 1 call
for fetching all the orders and 2 * Num of Orders calls respectively
to the Product and OrderItem tables. We can reduce this to three calls
by prefetch data

``` ruby
Order.includes(order_items: [:product]).each do |order|
  puts "Order #{order.id} has the following products:"
  order.order_items.each do |order_item|
    puts order_item.product.name
  end
end
```

## Further Reading

* [Bundler](http://bundler.io)
* [Ruby Gems](https://rubygems.org/)
* [Ruby On Rails](http://rubyonrails.org/)
* [Active Record Narrative Gudies](http://guides.rubyonrails.org/)
* [Active Record Developer Docs](https://api.rubyonrails.org)
