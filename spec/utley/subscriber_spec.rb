require_relative '../spec_helper'

describe Utley::Subscriber do

  describe "for" do

    describe "given a publisher and an event" do

      let(:publisher) { Struct.new(:id).new('a') }
      let(:event)     { Struct.new(:id).new('1') }

      it "should look up who is subscribed to this publisher and this event" do
        subscriber = Object.new
        registry   = [ { publisher_id: 'a', event_id: '1' } ]

        Utley::Subscriber.stubs(:registry).returns registry
        Utley::Subscriber.stubs(:build_from).with(registry.first).returns subscriber

        result = Utley::Subscriber.for publisher, event

        result.must_be_same_as subscriber
      end

    end

  end

end
