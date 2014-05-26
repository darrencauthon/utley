require_relative '../spec_helper'

describe Utley::Tick do

  describe "tock" do

    describe "when there is one agent to execute" do

      let(:agent) { Utley::Agent.new }

      before do
        Utley::Agent.stubs(:pending).returns [agent]
      end

      describe "and the check resulted in one event" do

        let(:events) { Object.new }

        let(:check_response) do
          r = Object.new
          r.stubs(:events).returns events
          r
        end

        before do
          agent.stubs(:check).returns check_response
        end

        it "should call publish the events from the check" do
          Utley.expects(:publish).with events
          Utley::Tick.tock
        end

      end

    end

  end

end
