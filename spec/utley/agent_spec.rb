require_relative '../spec_helper'

describe Utley::Agent do

  it "should exist" do
    true.must_equal true  
  end

  describe "receive" do
    it "should exist" do
      agent = Utley::Agent.new
      agent.receive nil
    end
  end

end
