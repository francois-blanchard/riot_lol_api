require 'riot_lol_api/model/leveltip'
require 'riot_lol_api/model/image'
require 'riot_lol_api/model/var'

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