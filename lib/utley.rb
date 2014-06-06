require "utley/version"
Dir[File.dirname(__FILE__) + '/utley/*.rb'].each {|file| require file }

module Utley
  def self.publish events
  end
end
