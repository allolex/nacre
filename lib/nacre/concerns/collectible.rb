# frozen_string_literal: true
module Nacre
  module Collectible
    def self.included(base)
      base.class_exec do
        def initialize(resource_list = []) # rubocop:disable NestedMethodDefinition
          @members = []

          resource_list.each do |resource_params|
            members << self.class.resource_class.new(resource_params)
          end
        end
      end
    end

    def members
      @members
    end

    def members=(list)
      @members = list
    end

    def each
      members.each do |member|
        yield member
      end
    end

    def params
      members.map(&:params)
    end
  end
end
