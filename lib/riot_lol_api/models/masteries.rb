module RiotLolApi
  module Model
    class Mastery
      def initialize(options = {})
        options.each do |key, value|
          self.class.send(:attr_accessor, key.to_sym)
          instance_variable_set("@#{key}", value)
        end
      end

      def infos(data = {}, locale = 'fr_FR')
        data.merge!(locale: locale)
        response = Client.get(url: "static-data/euw/v1.2/mastery/#{@id}", domaine: 'global', data: data)
        return nil if response.nil?
        RiotLolApi::Model::Mastery.new(response.lol_symbolize.merge(client: @client))
      end
    end
  end
end
