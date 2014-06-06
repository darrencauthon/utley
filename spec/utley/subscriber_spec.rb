require_relative '../spec_helper'

describe Utley::Subscriber do

  describe "for" do

    describe "given a publisher and an event" do

      [
        ['a', '1', 0],
        ['b', '2', 1],
        ['b', '2', 3],
      ].map { |x| Struct.new(:publisher_id, :event_id, :registry_index).new(*x) }.each do |example|
        describe "multiple examples" do

          let(:publisher) { Struct.new(:id).new(example.publisher_id) }
          let(:event)     { Struct.new(:id).new(example.event_id) }

          let(:our_registry_item) do
            { publisher_id: example.publisher_id, event_id: example.event_id }
          end

          let(:registry) do
            [ 
              { publisher_id: example.publisher_id + 'a', event_id: example.event_id + 'b' },
              { publisher_id: example.publisher_id + 'b', event_id: example.event_id + 'c' },
              { publisher_id: example.publisher_id + 'c', event_id: example.event_id + 'd' },
              { publisher_id: example.publisher_id + 'd', event_id: example.event_id + 'e' }
            ].insert(example.registry_index, our_registry_item)
          end

          it "should look up who is subscribed to this publisher and this event" do
            subscriber = Object.new

            Utley::Subscriber.stubs(:registry).returns registry
            Utley::Subscriber.stubs(:build_from).with(our_registry_item).returns subscriber

            result = Utley::Subscriber.for publisher, event

            result.must_be_same_as subscriber
          end

        end

      end

    end

  end

end
