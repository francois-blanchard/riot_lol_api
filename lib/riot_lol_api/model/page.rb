require 'riot_lol_api/model/mastery'
require 'riot_lol_api/model/slot'

module RiotLolApi
  module Model
    class Page

      def initialize(options = {})
        options.each do |key, value|
          self.class.send(:attr_accessor, key.to_sym)
          instance_variable_set("@#{key}", value)
        end
      end

    end
  end
end
