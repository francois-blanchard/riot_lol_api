require 'riot_lol_api/model/slot'

module RiotLolApi
  module Model
    class Rune

      # attr :id_rune, :name, :current, :slots

      def initialize(options = {})
        options.each do |key, value|
          self.class.send(:attr_accessor, key.to_sym)
          instance_variable_set("@#{key}", value)
        end
      end

    end
  end
end