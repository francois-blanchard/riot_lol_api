require 'riot_lol_api/model/golds'
require 'riot_lol_api/model/effects'
require 'riot_lol_api/model/maps'

module RiotLolApi
  module Model
    class Item

      def initialize(options = {})
        options.each do |key, value|
          self.class.send(:attr_accessor, key.to_sym)
          instance_variable_set("@#{key}", value)
        end
      end

    end
  end
end
