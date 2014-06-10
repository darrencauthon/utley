require_relative '../spec_helper'

describe Utley::Agent do

  describe "receive" do
    it "should exist" do
      agent = Utley::Agent.new
      agent.receive nil
    end
  end

end
