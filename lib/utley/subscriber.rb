module Utley

  module Subscriber

    def self.for publisher, event
      registry_entries_for(publisher, event).map { |x| build_from x }
    end

    class << self
      private

      def registry_entries_for publisher, event
        registry.select { |x| x[:publisher_id] == publisher.id &&
                              x[:event_id]     == event.id }
      end
    end

  end

end
