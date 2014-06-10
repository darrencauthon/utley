module Utley
  class Agent
    attr_accessor :data
    def initialize data = {}
      @data = data
    end

    # needs: receive(event)
  end
end
