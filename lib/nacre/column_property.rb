require "nacre/abstract_resource"

module Nacre
  class ColumnProperty < AbstractResource
    include Inflectible

    attribute :name
    attribute :sortable
    attribute :filterable
    attribute :report_data_type
    attribute :required

    def formatted_name
      snake_case(name).to_sym
    end
  end
end
