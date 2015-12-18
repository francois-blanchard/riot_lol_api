module RiotLolApi
  module Model
    class Team
      def initialize(options = {})
        options.each do |key, value|
          self.class.send(:attr_accessor, key.to_sym)
          instance_variable_set("@#{key}", value)
        end
      end

      def win?
        winner
      end
    end
  end
end
