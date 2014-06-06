module Utley

  module Subscriber

    def self.for publisher, event
      build_subscribers_from registry_entries_for(publisher, event)
    end

    class << self
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
