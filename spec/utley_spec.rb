require_relative 'spec_helper'

describe Utley do

  describe "publish" do

    describe "when there is one event" do

      let(:events) { [Object.new]}

      describe "and there's one subscriber for the event" do

        let(:subscribers) { [Object.new] }

        before do
          Utley::Subscriber.stubs(:for).with(events.first).returns subscribers
        end

        it "should create the subscriber and pass the even to it" do
          subscribers.first.expects(:receive).with events.first
          Utley.publish events
        end

      end

      describe "and there are two subscribers for the event" do

        let(:subscribers) { [Object.new, Object.new] }

        before do
          Utley::Subscriber.stubs(:for).with(events.first).returns subscribers
        end

        it "should create the subscriber and pass the even to it" do
          subscribers[0].expects(:receive).with events.first
          subscribers[1].expects(:receive).with events.first
          Utley.publish events
        end

      end

    end

    describe "when there are two events" do

      let(:events) { [Object.new, Object.new]}

      describe "and there's one subscriber for both events" do

        let(:subscribers1) { [Object.new] }
        let(:subscribers2) { [Object.new] }

        before do
          Utley::Subscriber.stubs(:for).with(events[0]).returns subscribers1
          Utley::Subscriber.stubs(:for).with(events[1]).returns subscribers2
        end

        it "should pass the events to the subscribers" do
          subscribers1[0].expects(:receive).with events[0]
          subscribers2[0].expects(:receive).with events[1]
          Utley.publish events
        end

      end

    end

  end

end

