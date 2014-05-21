require 'riot_lol_api/model/player'
require 'riot_lol_api/model/stat'

module RiotLolApi
  module Model
    class Game

      # attr :champion_id, :create_date, :create_date_str, :fellow_players, :game_id, :game_mode, :game_type, :level, :map_id, :spell1, :spell2, :stats, :sub_type, :team_id

      def initialize(options = {})
        options.each do |key, value|
          self.class.send(:attr_accessor, key.to_sym)
          instance_variable_set("@#{key}", value)
        end
      end

    end
  end
end