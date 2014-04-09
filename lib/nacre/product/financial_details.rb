require 'nacre/abstract_resource'

module Nacre
  class Product::FinancialDetails < AbstractResource

    attribute :tax_code

    def tax_code=(params)
      @tax_code = Product::TaxCode.new(params)
    end

  end
end
