require 'riot_lol_api/models/fellow_players'
require 'riot_lol_api/models/stats'

module RiotLolApi
  module Model
    class Game
      # attr :champion_id, :create_date, :create_date_str, :fellow_players, :game_id, :game_mode, :game_type, :level, :map_id, :spell1, :spell2, :stats, :sub_type, :team_id

      include RiotLolApi::Concern::Init
    end
  end
end
