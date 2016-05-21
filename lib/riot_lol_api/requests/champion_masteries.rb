module RiotLolApi
  module Request
    module ChampionMastery
      def championmastery_by_summoner_by_champion(summoner_id:, champion_id:)
        response = get(url: "championmastery/location/#{@platform}/player/#{summoner_id}/champion/#{champion_id}", domaine: @region, overide_base_uri: 'api.pvp.net/')
        return nil if response.nil?
        RiotLolApi::Model::ChampionMastery.new(response.lol_symbolize)
      end
    end
  end
end
