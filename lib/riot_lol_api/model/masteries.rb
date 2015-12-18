module RiotLolApi
  module Model
    class Mastery
      def initialize(options = {})
        options.each do |key, value|
          self.class.send(:attr_accessor, key.to_sym)
          instance_variable_set("@#{key}", value)
        end
      end

      def infos(data = nil, locale = 'fr_FR')
        if data.nil?
          data = { locale: locale }
        else
          data.merge!(locale: locale)
        end

        # HACK: set region by default euw
        response = Client.get("static-data/euw/v1.2/mastery/#{@id}", 'global', data)
        RiotLolApi::Model::Mastery.new(response.lol_symbolize) unless response.nil?
      end
    end
  end
end
