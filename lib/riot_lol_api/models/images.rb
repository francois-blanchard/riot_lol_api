module RiotLolApi
  module Model
    class Image
      def initialize(options = {})
        options.each do |key, value|
          self.class.send(:attr_accessor, key.to_sym)
          instance_variable_set("@#{key}", value)
        end
      end

      # build path of image
      def full_url
        "#{RiotLolApi::Client.realm['cdn']}/#{RiotLolApi::Client.realm['v']}/img/#{group}/#{full}"
      end

      def sprite_url(size = 'normal')
        filename = size == 'tiny' || size == 'small' ? "#{size}_#{sprite}" : sprite
        "#{RiotLolApi::Client.realm['cdn']}/#{RiotLolApi::Client.realm['v']}/img/sprite/#{filename}"
      end
    end
  end
end
