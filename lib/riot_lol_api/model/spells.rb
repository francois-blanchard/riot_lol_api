require 'riot_lol_api/model/leveltips'
require 'riot_lol_api/model/images'
require 'riot_lol_api/model/vars'
require 'riot_lol_api/model/altimages'

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
