require 'nacre/concerns/inflectible'

module Nacre

  class SearchResultsError < ArgumentError; end

  class SearchResults

    extend Inflectible
    include Enumerable

    attr_accessor :results

    def initialize(params_list = [])
      @results = []
      params_list.each do |params|
        @results << params
      end
    end

    def self.from_json(results_json)
      raise SearchResultsError.new('Empty JSON') unless results_json.length > 2
      list = result_params_list(results_json)
      new(list)
    end

    def each(&block)
      self.results.each do |order|
        block.call(order)
      end
    end

    private

    def self.result_params_list(results)
      keys = keys_from_metadata(results)
      list = resources_from_results(results)
      list.map { |resource| convert_to_params(keys, resource) }
    end

    def self.resources_from_results(results)
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
