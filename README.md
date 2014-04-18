[![Build Status](https://travis-ci.org/allolex/nacre.svg?branch=master)](https://travis-ci.org/allolex/nacre) [![Coverage Status](https://coveralls.io/repos/allolex/nacre/badge.png?branch=master)](https://coveralls.io/r/allolex/nacre?branch=master) [![Code Climate](https://codeclimate.com/github/allolex/nacre.png)](https://codeclimate.com/github/allolex/nacre) [![Dependency Status](https://gemnasium.com/allolex/nacre.svg)](https://gemnasium.com/allolex/nacre)


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


## CONTRIBUTING

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

Please keep formatting "fixes" separate from actual code changes/improvements. *De gustibus non est disputandum* and no one is perfect. :wink:

## Thanks 

Many thanks go to Angela Heenan at and Helen Bowling at Brightpearl.
