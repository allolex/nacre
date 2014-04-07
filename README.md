# Nacre, the sequel

Nacre is a Ruby gem that wraps the API of the Brightpearl accounting software service.

http://www.brightpearl.com/developer/latest/

Version 0.1.0 of this library is a complete re-write of the original version. We've all learned a few things since we first started and refactoring was too much trouble.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "nacre", :git => "git://github.com/allolex/nacre.git"
```

And then execute:

```
$ bundle
```

## Usage

Here's how I'm testing the gem as I develop it. It's just a throw-away script,
but it should get you started. It has some redundant bits. :smile:

```ruby

    require 'nacre'
    require 'awesome_print'

    Nacre.configure do |c|
      c.user_id = 'YOUR_USER_ID'
      c.email = 'YOUR_BRIGHTPEARL_EMAIL'
      c.password = 'YOUR_BRIGHTPEARL_PASSWORD'
    end

    # ap Nacre.configuration

    bp = Nacre::Connection.new(
      user_id: Nacre.configuration.user_id,
      email: Nacre.configuration.email,
      password: Nacre.configuration.password
    )

    puts "Link authenticated? #{bp.authenticated?}"

    unless bp.response.success?
      bp.response.errors.each do |error|
        puts "Error: " + error['message']
      end
    end

    if bp.response.success?
      results = Nacre::Order.find(date: '2012-12-14')
      results.orders.each do |order_params|
        ap order_params
        order = Nacre::Order.new(order_params)
        ap order.params
      end
    end
```

## DEVELOPMENT


We're using the [Dotenv](https://github.com/bkeepers/dotenv) gem for
development. Create a `.env` file in the root of the development repository and
add the following lines:

```

    NACRE_USER_ID: YOUR_BRIGHTPEARL_TEST_ACCOUNT_USER_ID
    NACRE_EMAIL: YOUR_BRIGHTPEARL_TEST_ACCOUNT_EMAIL
    NACRE_PASSWORD: YOUR_BRIGHTPEARL_TEST_ACCOUNT_PASSWORD
    NACRE_CENTER: eu1
    NACRE_API_VERSION: 2.0.0
```


## TODO

Have a look at the issues in Nacre's GitHub repository.


