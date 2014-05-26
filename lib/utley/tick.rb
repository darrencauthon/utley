module Utley
  module Tick
    def self.tock
      Utley::Agent.pending.each do |agent|
        events = agent.check.events
        Utley.publish events if events.count > 0
      end
    end
  end
end
