module RiotLolApi
  module Model
    class Image
      include RiotLolApi::Concern::Init

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
