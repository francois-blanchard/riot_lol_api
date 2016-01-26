module RiotLolApi
  module Model
    class Mastery
      include RiotLolApi::Concern::Init

      def infos(data = {}, locale = 'fr_FR')
        data.merge!(locale: locale)
        response = Client.get(url: "static-data/euw/v1.2/mastery/#{@id}", domaine: 'global', data: data)
        return nil if response.nil?
        RiotLolApi::Model::Mastery.new(response.lol_symbolize.merge(client: @client))
      end
    end
  end
end
