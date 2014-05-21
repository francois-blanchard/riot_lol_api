require 'riot_lol_api/model/talent'

module RiotLolApi
  module Model
    class Mastery

      # attr :id_mastery, :name, :current, :talents

      def initialize(options = {})
        options.each do |key, value|
          self.class.send(:attr_accessor, key.to_sym)
          instance_variable_set("@#{key}", value)
        end
      end

    end
  end
end