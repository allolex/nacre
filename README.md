[![Build Status](https://travis-ci.org/allolex/nacre.svg?branch=master)](https://travis-ci.org/allolex/nacre) [![Coverage Status](https://coveralls.io/repos/allolex/nacre/badge.png?branch=master)](https://coveralls.io/r/allolex/nacre?branch=master) [![Code Climate](https://codeclimate.com/github/allolex/nacre.png)](https://codeclimate.com/github/allolex/nacre) [![Dependency Status](https://gemnasium.com/allolex/nacre.svg)](https://gemnasium.com/allolex/nacre)


# Nacre

Nacre is a Ruby gem that wraps the API of the Brightpearl accounting software service.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "nacre", git: "git://github.com/allolex/nacre.git"
```

And then execute:

```
$ bundle
```


## FEATURES


### Supported API resources


#### Orders

- search for orders, e.g. `Nacre::Order.find`
- retrieve a single order, e.g. `Nacre::Order.get(1)`
- retrieve an order collection, e.g. `OrderCollection.get('1,2,3')`


#### Products

- search for products, e.g. `Nacre::Product.find`
- retrieve a single product, e.g. `Nacre::Product.get(1)`


#### Channels

- retrieve a single channel, e.g. `Nacre::Channel.get(2)`
- retrieve a list of channels, e.g. `Nacre::Channel.get(1-4)`


#### Journals

- search for journals, e.g. `Nacre::Journal.find`
- retrieve a single journal, e.g. `Nacre::Journal.get(2)`
- retrieve a list of journals, e.g. `Nacre::Journal.get(1-4)`

#### Nominal Codes

### Lazily-loading searches

Brightpearl currently returns a maximum of 500 search results. If you need to
conserve local resources, you can configure your searches to return fewer
results on each page. Nacre will load the next page of search results when it
hits the end of the current page.


## Usage


### Searching

When using the API's search endpoint, the API returns search results that
include some of the attributes from the queried resource, but not all. You may
want to combine a search with pulling in a collection for that resource. This
will generally be more efficient if the search provides data you can use to
filter the resources you'd like to get from the API.

For example, you want to get the first two orders from Brightpearl:

```ruby

    order_search = Nacre::Order.find                        # Search for all orders
    order_ids = order_search.map { |rec| rec[:order_id] }   # Make a list of all the id's
    orders_list = order_ids.first(2).join(',')              # Parametrize the first two id's from the search
    orders = Nacre::OrderCollection.get(orders_list)        # Retreive the orders as an OrderCollection.
    orders.each do |order|
      # do stuff
    end
```

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
      results = Nacre::Order.find
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


### To Do

This library is still under active development. The 
[Brightpearl Developer documentation](http://www.brightpearl.com/developer/latest/) 
shows there are a number of areas that could use help.

- Creating, updating, deleting all resources.
- Search resources by creation date.
- [Warehouse resource support](https://www.brightpearl.com/developer/latest/warehouse/index.html).
- Full [Price List support](https://www.brightpearl.com/developer/latest/product/price-list/index.html) (currently partially supported).
- [Contact resource support](https://www.brightpearl.com/developer/latest/contact/index.html).
- [Brightpearl Category support](https://www.brightpearl.com/developer/latest/product/brightpearl-category/index.html).


### Notes

As of version 0.1.0, this library is a complete re-write of the original
version. We've all learned a few things since we first started and refactoring
was too much trouble.


## CONTRIBUTING

1. Fork it
2. Create your feature branch (`git checkout -b feature/my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin feature/my-new-feature`)
5. Create new Pull Request

Please keep formatting "fixes" separate from actual code changes/improvements.
*De gustibus non est disputandum* and no one is perfect. :wink:

## Thanks 

Many thanks go to Angela Heenan at and Helen Bowling at Brightpearl.
