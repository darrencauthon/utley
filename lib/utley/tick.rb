module Utley
  module Tick
    def self.tock
      events = Utley::Agent.pending.first.check.events
      Utley.publish events if events.count > 0
    end
  end
end
