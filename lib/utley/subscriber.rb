module Utley

  module Subscriber

    def self.for publisher, event
      registry_record = registry.select { |x| x[:publisher_id] == publisher.id &&
                                              x[:event_id]     == event.id }.first
      build_from registry_record
    end

  end

end
