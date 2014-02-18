require 'nacre/concerns/inflectible'

module Nacre

  class OrderSearchResultsError < ArgumentError; end

  class OrderSearchResults

    extend Inflectible

    attr_accessor :orders

    def initialize(order_params_list = [])
      @orders = []
      order_params_list.each do |order_params|
        @orders << order_params
      end
    end

    def self.from_json(results_json)
      raise OrderSearchResultsError.new('Empty JSON') unless results_json.length > 2
      list = order_params_list(results_json)
      new(list)
    end

    private

    def self.order_params_list(results)
      keys = keys_from_metadata(results)
      order_list = orders_from_results(results)
      order_list.map { |order| convert_to_params(keys, order) }
    end

    def self.orders_from_results(results)
      hash = JSON.parse(results)
      hash['response']['results']
    end

    def self.convert_to_params(keys, values)
      params = {}
      keys.each_with_index do |key, index|
        params[snake_case(key).to_sym] = values[index].to_s
      end
      params
    end

    def self.keys_from_metadata(results)
      hash = JSON.parse(results)
      columns = hash['response']['metaData']['columns']
      columns.map { |c| c['name'] }
    end
  end
end
