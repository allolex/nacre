require 'nacre/abstract_resource'

module Nacre
  class Product::Description < AbstractResource

    attribute :language_code
    attribute :text
    attribute :format

  end
end
