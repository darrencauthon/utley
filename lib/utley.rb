require "utley/version"
Dir[File.dirname(__FILE__) + '/utley/*.rb'].each {|file| require file }

module Utley
  def self.publish events
    events.each do |event|
      subscribers = Utley::Subscriber.for(event)
      subscribers.each do |subscriber|
        subscriber.receive event
      end
    end
  end
end
