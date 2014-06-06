require_relative '../spec_helper'

describe Utley::Subscriber do

  describe "for" do

    describe "given a publisher and an event" do

      [
        ['a', '1', 0],
        ['b', '2', 1],
        ['b', '2', 3],
      ].map { |x| Struct.new(:publisher_id, :event_id, :registry_index).new(*x) }.each do |example|

        describe "multiple examples of one match" do

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

            results = Utley::Subscriber.for publisher, event

            results.first.must_be_same_as subscriber
          end

        end

        describe "multiple examples of two matches" do

          let(:publisher) { Struct.new(:id).new(example.publisher_id) }
          let(:event)     { Struct.new(:id).new(example.event_id) }

          let(:our_registry_item_1) do
            { publisher_id: example.publisher_id, event_id: example.event_id, something_specific: 1 }
          end

          let(:our_registry_item_2) do
            { publisher_id: example.publisher_id, event_id: example.event_id, something_different: 2 }
          end

          let(:registry) do
            [ 
              { publisher_id: example.publisher_id + 'a', event_id: example.event_id + 'b' },
              { publisher_id: example.publisher_id + 'b', event_id: example.event_id + 'c' },
              { publisher_id: example.publisher_id + 'c', event_id: example.event_id + 'd' },
              { publisher_id: example.publisher_id + 'd', event_id: example.event_id + 'e' }
            ].insert(example.registry_index, our_registry_item_2)
             .insert(example.registry_index, our_registry_item_1)
          end

          it "should return both subscribers" do
            subscriber_1 = Object.new
            subscriber_2 = Object.new

            Utley::Subscriber.stubs(:registry).returns registry
            Utley::Subscriber.stubs(:build_from).with(our_registry_item_1).returns subscriber_1
            Utley::Subscriber.stubs(:build_from).with(our_registry_item_2).returns subscriber_2

            results = Utley::Subscriber.for publisher, event

            results.count.must_equal 2
            results[0].must_be_same_as subscriber_1
            results[1].must_be_same_as subscriber_2
          end

        end

      end

    end

  end

end
