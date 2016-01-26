module RiotLolApi
  module Request
    module Game
      def featured_games
        response = get(url: 'observer-mode/rest/featured', domaine: @region, overide_base_uri: 'api.pvp.net/')
        return nil if response.nil?
        RiotLolApi::Model::Observer.new(response.lol_symbolize)
      end

      def current_game(summoner_id, platform_id = 'EUW1')
        response = get(url: "observer-mode/rest/consumer/getSpectatorGameInfo/#{platform_id}/#{summoner_id}", domaine: @region, overide_base_uri: 'api.pvp.net/')
        return nil if response.nil?
        RiotLolApi::Model::Game.new(response.lol_symbolize)
      end

      def match(game_id)
        response = get(url: "#{@region}/v2.2/match/#{game_id}", domaine: @region)
        return nil if response.nil?
        RiotLolApi::Model::Match.new(response.lol_symbolize)
      end
    end
  end
end
