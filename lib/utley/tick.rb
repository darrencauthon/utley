module Utley
  module Tick
    def self.tock
      Utley.publish Utley::Agent.pending.first.check.events
    end
  end
end
