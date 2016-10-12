require "nacre/concerns/inflectible"

module Nacre
  class SearchResultsError < ArgumentError; end

  class SearchResults
    extend Inflectible
    include Enumerable

    attr_accessor :results, :last_result, :first_result,
                  :total_results, :returned_results, :columns

    def initialize(params = {})
      @results = []
      unless params.empty? || params[:errors] || params[:response].empty?
        extract_metadata(params[:response][:meta_data])
        extract_results(params[:response][:results])
      end
    end

    def self.from_json(json)
      unless json.length > 2
        raise SearchResultsError, "Empty JSON"
      end

      params = format_hash_keys(JSON.parse(json, symbolize_names: true))
      new(params)
    end

    def each(&block)
      results.each do |order|
        block.call(order)
      end
    end

    private

    def extract_results(params)
      self.results = []
      formatted_params = result_params_list(params)
      formatted_params.each do |result|
        results << result
      end
    end

    def extract_metadata(metadata)
      self.columns = extract_column_properties(metadata[:columns])
      self.last_result = metadata[:last_result]
      self.first_result = metadata[:first_result]
      self.total_results = metadata[:results_available]
      self.returned_results = metadata[:results_returned]
    end

    def extract_column_properties(params)
      params.map { |col_params| ColumnProperty.new(col_params) }
    end

    def result_params_list(results)
      keys = columns.map(&:formatted_name)
      results.map { |resource| convert_to_params(keys, resource) }
    end

    def convert_to_params(keys, values)
      params = {}
      keys.each_with_index do |key, index|
        params[key] = values[index].to_s
      end
      params
    end
  end
end
