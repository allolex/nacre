module Nacre
  class Order::Assignment < AbstractResource

    attribute :channel_id
    attribute :project_id
    attribute :lead_source_id
    attribute :staff_owner_contact_id
    attribute :team_id

    attr_accessor :key

    def initialize(key, options = {})
      self.key = key
      self.attributes = options
    end
  end
end
