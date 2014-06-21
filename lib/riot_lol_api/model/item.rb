require 'riot_lol_api/model/gold'
require 'riot_lol_api/model/map'

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