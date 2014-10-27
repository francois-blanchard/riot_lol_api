require 'riot_lol_api/model/entries'
require 'riot_lol_api/model/mini_series'

module RiotLolApi
  module Model
    class League

      def initialize(options = {})
        options.each do |key, value|
          self.class.send(:attr_accessor, key.to_sym)
          instance_variable_set("@#{key}", value)
        end
      end

    end
  end
end
