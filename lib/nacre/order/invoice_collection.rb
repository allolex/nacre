module Nacre
  class Order::InvoiceCollection

    include Enumerable

    attr_accessor :members

    def initialize(resource_list = [])
      self.members = []
      resource_list.each do |resource_params|
        members << Nacre::Order::Invoice.new(resource_params)
      end
    end

    def each(&block)
      members.each do |member|
        block.call(member)
      end
    end

    def params
      members.map(&:params)
    end

  end
end
