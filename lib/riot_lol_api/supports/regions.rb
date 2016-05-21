module RiotLolApi
  module Support
    class Region
      attr_accessor :region, :platform
      def initialize(region)
        @region = region
        @platform = find_platform
      end

      def find_platform
        list[@region.to_sym]
      end

      private

      def list
        {
          br: 'BR1',
          eune: 'EUNE1',
          euw: 'EUW1',
          kr: 'KR',
          lan: 'LA1',
          las: 'LA2',
          na: 'NA1',
          oce: 'OC',
          ru: 'RU',
          tr: 'TR1'
        }
      end

    end
  end
end
