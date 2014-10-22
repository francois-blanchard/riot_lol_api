FactoryGirl.define do
	factory :game, :class => RiotLolApi::Model::Game do
		game_id 1764353660
		invalid false
		game_mode "CLASSIC"
		game_type "MATCHED_GAME"
		sub_type "NORMAL"
		map_id 1
		team_id 200
		champion_id 40
		spell1 4
		spell2 3
		level 30
		ip_earned 235
		create_date 1414008147108
		fellow_players []
		stats []
		initialize_with { new(:game_id => game_id, :invalid => invalid, :game_mode => game_mode, :game_type => game_type, :sub_type => sub_type, :map_id => map_id, :team_id => team_id, :champion_id => champion_id, :spell1 => spell1, :spell2 => spell2, :level => level, :ip_earned => ip_earned, :create_date => create_date) }
	end
end
