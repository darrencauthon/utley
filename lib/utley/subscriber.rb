module Utley

  module Subscriber

    def self.for publisher, event
      registry.select { |x| x[:publisher_id] == publisher.id &&
                            x[:event_id]     == event.id }
              .map    { |x| build_from x }
    end

  end

end
