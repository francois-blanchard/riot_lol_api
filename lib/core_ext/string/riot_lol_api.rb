module CoreExt
  module String
    module RiotLolApi
      def lol_symbolize
        gsub(/([a-z\d])([A-Z])/, '\1_\2').downcase.to_sym
      end
    end
  end
end
