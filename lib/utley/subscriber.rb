require 'active_support/inflector'

module Utley

  module Subscriber

    def self.for publisher, event
      build_subscribers_from registry_entries_for(publisher, event)
    end

    def self.build_from registry_record
      "#{registry_record[:agent_type]}_agent".camelize.constantize.new registry_record
    end

    class << self

      def registry
        @registry ||= []
      end

      private

      def build_subscribers_from registry_entries
        registry_entries.map { |x| build_from x }
      end

      def registry_entries_for publisher, event
        registry.select { |x| x[:publisher_id] == publisher.id &&
                              x[:event_id]     == event.id }
      end

    end

  end

end
