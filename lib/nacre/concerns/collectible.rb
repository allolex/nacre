module Nacre::Collectible
  def self.included(base)
    base.class_exec do
      def initialize(resource_list = [])
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

  def each(&block)
    members.each do |member|
      block.call(member)
    end
  end

  def params
    members.map(&:params)
  end
end
