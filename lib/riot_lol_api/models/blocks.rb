require 'riot_lol_api/models/items'

module RiotLolApi
  module Model
    class Block
      def initialize(options = {})
        options.each do |key, value|
          self.class.send(:attr_accessor, key.to_sym)
          instance_variable_set("@#{key}", value)
        end
      end
    end
  end
end
