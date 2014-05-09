module Nacre
  class SearchResultsCollection < AbstractCollection

    attr_accessor :total, :request_url

    include Searchable

    def initialize(params: [], options: {})
      self.members = []
      params.each do |resource_params|
        members << resource_class.new(resource_params)
      end
      self.total = members.first.total_results
      self.request_url = RequestUrl.new(options)
    end

    def more_records?(record_count)
      !(record_count == self.total.to_i)
    end

    def no_more_members?(member_index)
      !(member_index < members.count - 1)
    end

    def last_result?(count, index)
      index == count - 1
    end

    def each(&block)
      record_count = 0
      members.each_with_index do |search_results, search_results_index|
        search_results.each_with_index do |resource, resource_index|
          record_count += 1
          if search_again?( collection_index: search_results_index,
                            available_records: record_count,
                            resource_count: search_results.count,
                            current_resource_index: resource_index )
            search_again(record_count + 1)
          end
          block.call(resource)
        end
      end
    end

    private

    def search_again?(args = {})
      no_more_members?(args[:collection_index]) &&
        more_records?(args[:available_records]) &&
        last_result?(args[:resource_count],args[:current_resource_index])
    end

    def search_again(starting_record)
      new_url = self.request_url
      new_url.pagination = {
        first_record: starting_record,
        window: self.request_url.pagination_params[:window]
      }
      response = link.get(new_url.to_s)
      self.members << Nacre::SearchResults.from_json(response.body)
    end

    def resource_class
      SearchResults
    end

    def self.service_name
      'order'
    end

    def search_url
      service_url + '/' + service_name + '-search'
    end

    def link
      Nacre.link
    end

  end
end
