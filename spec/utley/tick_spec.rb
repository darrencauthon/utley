require_relative '../spec_helper'

describe Utley::Tick do

  describe "tock" do

    describe "when there is one agent to execute" do

      let(:agent) { Utley::Agent.new }

      before do
        Utley::Agent.stubs(:pending).returns [agent]
      end

      describe "and the check resulted in one event" do

        let(:events) { [Object.new] }

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

      describe "and the check resulted in no events" do

        let(:events) { [] }

        let(:check_response) do
          r = Object.new
          r.stubs(:events).returns events
          r
        end

        before do
          agent.stubs(:check).returns check_response
        end

        it "should not call publish" do
          Utley.expects(:publish).never
          Utley::Tick.tock
        end

      end

    end

    describe "when there are two agents to execute" do

      let(:agent1) { Utley::Agent.new }
      let(:agent2) { Utley::Agent.new }

      before do
        Utley::Agent.stubs(:pending).returns [agent1, agent2]
      end

      describe "and events were returned by both" do

        let(:events1) { [Object.new] }
        let(:events2) { [Object.new] }

        let(:check_response1) do
          r = Object.new
          r.stubs(:events).returns events1
          r
        end

        let(:check_response2) do
          r = Object.new
          r.stubs(:events).returns events2
          r
        end

        before do
          agent1.stubs(:check).returns check_response1
          agent2.stubs(:check).returns check_response2
        end

        it "should call publish the events from both checks" do
          Utley.expects(:publish).with events1
          Utley.expects(:publish).with events2
          Utley::Tick.tock
        end

      end

    end

  end

end
