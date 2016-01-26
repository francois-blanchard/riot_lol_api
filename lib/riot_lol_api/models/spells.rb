require 'riot_lol_api/models/leveltips'
require 'riot_lol_api/models/images'
require 'riot_lol_api/models/vars'
require 'riot_lol_api/models/altimages'

module RiotLolApi
  module Model
    class Spell
      def initialize(options = {})
        options.each do |key, value|
          self.class.send(:attr_accessor, key.to_sym)
          instance_variable_set("@#{key}", value)
        end
      end
    end
  end
end
