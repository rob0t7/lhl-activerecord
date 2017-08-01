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

## Further Reading

* [Bundler](http://bundler.io)
* [Ruby Gems](https://rubygems.org/)
* [Ruby On Rails](http://rubyonrails.org/)
* [Active Record Narrative Gudies](http://guides.rubyonrails.org/)
* [Active Record Developer Docs](https://api.rubyonrails.org)
