module RiotLolApi
  module Request
    module Champion
      def get_champion_by_id(id, data = {}, locale = 'en_US')
        data.merge!(locale: locale)
        response = get(url: "static-data/#{@region}/v1.2/champion/#{id}", domaine: 'global', data: data)
        return nil if response.nil?
        RiotLolApi::Model::Champion.new(response.lol_symbolize)
      end

      def get_all_champions(data = {}, sort_id = 'false', locale = 'en_US')
        data.merge!(locale: locale, dataById: sort_id)
        response = get(url: "static-data/#{@region}/v1.2/champion", domaine: 'global', data: data)
        return nil if response.nil?
        tab_champions = []
        response['data'].each do |champion|
          tab_champions << RiotLolApi::Model::Champion.new(champion[1].lol_symbolize)
        end
        tab_champions
      end
    end
  end
end
