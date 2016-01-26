module RiotLolApi
  module Model
    class Map
      def initialize(options = {})
        options.each_with_index do |_key, value, i|
          if i == 0
            instance_variable_set('@map_id', value)
          elsif i == 1
            instance_variable_set('@active', value)
          end
        end
      end
    end
  end
end
