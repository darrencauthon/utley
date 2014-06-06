module Utley

  module Subscriber

    def self.for publisher, event
      build_from(registry.first)
    end

  end

end
