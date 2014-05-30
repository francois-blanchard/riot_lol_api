require 'spec_helper'
require 'riot_lol_api'
require 'pp'

describe RiotLolApi::Client do

	describe "can use string and hash ovewriting method" do

		it "transform string CamelCase in to symbol" do
			test = "lolApiTest"
			expect(test.to_symbol).to eq :lol_api_test
		end

		it "transform hash keys CamelCase in to symbol" do
			hash_test = {"lolApiTest" => "lol", "testLol" => "truc"}
			expect(hash_test.to_symbol).to eq({:lol_api_test => "lol", :test_lol => "truc"})
		end

		it "Add instance of class to_symbol" do
			hash_result = {"lolApiTest" => "lol", "testLol" => "truc", "masteries" => [{"id" => 4212,"rank" => 2},{"id" => 4233,"rank" => 3}], "stats" => {"truc" => 0, "machin" => 2}}.to_symbol
			# Test Array
			expect(hash_result[:masteries][0]).to be_a RiotLolApi::Model::Mastery
			# Test Hash
			expect(hash_result[:stats]).to be_a RiotLolApi::Model::Stat
		end

	end

	describe "get_summoner_by_name" do

		before(:each) do
			# Create client
			client = FactoryGirl.build(:client)
			name = "pacoloco"

			api_response = File.read 'spec/mock_response/get_summoner_by_name.json'
			stub_request(:get, "https://prod.api.pvp.net/api/lol/euw/v1.4/summoner/by-name/#{name}?api_key=#{RiotLolApi::TOKEN}").to_return(api_response)

			@summoner_test = client.get_summoner_by_name(name)
		end

		it "should get summoner object" do
			expect(@summoner_test).to be_a RiotLolApi::Model::Summoner
		end

		it "should have good attributes" do
			summoner = FactoryGirl.build(:summoner)

			expect(@summoner_test.id).to eq(summoner.id)
			expect(@summoner_test.name).to eq(summoner.name)
			expect(@summoner_test.profile_icon_id).to eq(summoner.profile_icon_id)
			expect(@summoner_test.summoner_level).to eq(summoner.summoner_level)
			expect(@summoner_test.revision_date).to eq(summoner.revision_date)
			expect(@summoner_test.region).to eq(summoner.region)
		end
	end

	describe "get_summoner_by_id" do

		before(:each) do
			# Create client
			client = FactoryGirl.build(:client)
			id = 20639710

			api_response = File.read 'spec/mock_response/get_summoner_by_id.json'
			stub_request(:get, "https://prod.api.pvp.net/api/lol/euw/v1.4/summoner/#{id}?api_key=#{RiotLolApi::TOKEN}").to_return(api_response)

			@summoner_test = client.get_summoner_by_id(id)
		end

		it "should get summoner object" do
			expect(@summoner_test).to be_a RiotLolApi::Model::Summoner
		end

		it "should have good attributes" do
			summoner = FactoryGirl.build(:summoner)

			expect(@summoner_test.id).to eq(summoner.id)
			expect(@summoner_test.name).to eq(summoner.name)
			expect(@summoner_test.profile_icon_id).to eq(summoner.profile_icon_id)
			expect(@summoner_test.summoner_level).to eq(summoner.summoner_level)
			expect(@summoner_test.revision_date).to eq(summoner.revision_date)
			expect(@summoner_test.region).to eq(summoner.region)
		end
	end

	describe "get summoner masteries pages" do

		before(:each) do
			# Create summoner
			summoner = FactoryGirl.build(:summoner)

			api_response = File.read 'spec/mock_response/get_summoner_masteries_by_id.json'
			stub_request(:get, "https://prod.api.pvp.net/api/lol/euw/v1.4/summoner/#{summoner.id}/masteries?api_key=#{RiotLolApi::TOKEN}").to_return(api_response)

			@page_test = summoner.masteries
		end

		it "should have good attributes" do
			tab_pages = Array.new
			tab_pages << FactoryGirl.build(:page, :id => 37482369, :name => "support", :current => false, :masteries => [RiotLolApi::Model::Mastery.new(:id => 4212,:rank => 2),RiotLolApi::Model::Mastery.new(:id => 4233,:rank => 3)])
			tab_pages << FactoryGirl.build(:page, :id => 37482370, :name => "jungler", :current => false, :masteries => [RiotLolApi::Model::Mastery.new(:id => 4233,:rank => 3),RiotLolApi::Model::Mastery.new(:id => 4242,:rank => 1)])

			@page_test.each_with_index do |page,i|
				expect(page.id).to eq(tab_pages[i].id)
				expect(page.name).to eq(tab_pages[i].name)
				expect(page.current).to eq(tab_pages[i].current)
				page.masteries.each_with_index do |mastery,j|
					expect(mastery.id).to eq(tab_pages[i].masteries[j].id)
					expect(mastery.rank).to eq(tab_pages[i].masteries[j].rank)
				end
			end
		end
	end

	describe "get summoner runes" do

		before(:each) do
			# Create summoner
			summoner = FactoryGirl.build(:summoner)

			api_response = File.read 'spec/mock_response/get_summoner_runes_by_id.json'
			stub_request(:get, "https://prod.api.pvp.net/api/lol/euw/v1.4/summoner/#{summoner.id}/runes?api_key=#{RiotLolApi::TOKEN}").to_return(api_response)

			@rune_test = summoner.runes
		end

		it "should have good attributes" do
			tab_runes = Array.new
			tab_runes << FactoryGirl.build(:page, :id => 6182779, :name => "ad", :current => true, :slots => [RiotLolApi::Model::Slot.new(:rune_slot_id => 1,:rune_id => 5253),RiotLolApi::Model::Slot.new(:rune_slot_id => 2,:rune_id => 5253)])
			tab_runes << FactoryGirl.build(:page, :id => 6182780, :name => "ap", :current => false, :slots => [RiotLolApi::Model::Slot.new(:rune_slot_id => 1,:rune_id => 5245),RiotLolApi::Model::Slot.new(:rune_slot_id => 2,:rune_id => 5245)])

			@rune_test.each_with_index do |rune,i|
				expect(rune.id).to eq(tab_runes[i].id)
				expect(rune.name).to eq(tab_runes[i].name)
				expect(rune.current).to eq(tab_runes[i].current)
				rune.slots.each_with_index do |slot,j|
					expect(slot.rune_slot_id).to eq(tab_runes[i].slots[j].rune_slot_id)
					expect(slot.rune_id).to eq(tab_runes[i].slots[j].rune_id)
				end
			end
		end
	end

	describe "get summoner games" do

		before(:each) do
			# Create summoner
			summoner = FactoryGirl.build(:summoner)

			api_response = File.read 'spec/mock_response/get_summoner_games_by_id.json'
			stub_request(:get, "https://prod.api.pvp.net/api/lol/euw/v1.3/game/by-summoner/#{summoner.id}/recent?api_key=#{RiotLolApi::TOKEN}").to_return(api_response)

			@game_tests = summoner.games
		end

		it "should have good attributes" do
			game = FactoryGirl.build(:game, :fellow_players => [RiotLolApi::Model::FellowPlayer.new(:summoner_id => 228437,:team_id => 200, :champion_id => 102),RiotLolApi::Model::FellowPlayer.new(:summoner_id => 25235641,:team_id => 100, :champion_id => 48)], :stats => 
				RiotLolApi::Model::Stat.new(:ward_killed => nil, :vision_wards_bought => nil, :victory_point_total => nil, :unreal_kills => nil, :turrets_killed => nil, :true_damage_taken => nil, :true_damage_dealt_to_champions => nil, :true_damage_dealt_player => nil, :triple_kills => nil, :total_score_rank => nil, :total_player_score => nil, :team_objective => nil, :super_monster_killed => nil, :summon_spell2_cast => nil, :summon_spell1_cast => nil, :spell4_cast => nil, :spell3_cast => nil, :spell2_cast => nil, :spell1_cast => nil, :quadra_kills => nil, :penta_kills => nil, :objective_player_score => nil, :num_items_bought => nil, :node_neutralize_assist => nil, :node_neutralize => nil, :node_capture_assist => nil,:node_capture => nil, :nexus_killed => nil, :neutral_minions_killed_your_jungle => nil,:neutral_minions_killed_enemy_jungle => nil,:neutral_minions_killed => nil, :minions_denied => nil, :legendary_items_created => nil,:largest_multi_kill => nil, :largest_killing_spree =>nil, :largest_critical_strike => nil, :killing_sprees => nil, :items_purchased => nil,:item5 => nil, :gold_earned => 5969, :gold_spent => 5630,:first_blood => nil,:double_kills => nil,:consumables_purchased => nil, :combat_player_score => nil, :champions_killed => nil, :barracks_killed => nil,:level => 13, :num_deaths => 2, :minions_killed => 10, :total_damage_dealt => 19848, :total_damage_taken => 16127, :team => 200, :win => false, :physical_damage_dealt_player => 7116, :magic_damage_dealt_player => 12732, :physical_damage_taken => 7806, :magic_damage_taken => 8069, :time_played => 1597, :total_heal => 9241, :total_units_healed => 4, :assists => 8, :item0 => 3301, :item1 => 2049, :item2 => 3047, :item3 => 3110, :item4 => 1057, :item6 => 3340, :sight_wards_bought => 1, :magic_damage_dealt_to_champions => 3100, :physical_damage_dealt_to_champions => 1230, :total_damage_dealt_to_champions => 4330, :true_damage_taken => 252, :ward_placed => 14, :total_time_crowd_control_dealt => 602))

			@game_tests.each do |game_test|
				expect(game_test.game_id).to eq(game.game_id)
				expect(game_test.invalid).to eq(game.invalid)
				expect(game_test.game_mode).to eq(game.game_mode)
				expect(game_test.game_type).to eq(game.game_type)
				expect(game_test.sub_type).to eq(game.sub_type)
				expect(game_test.map_id).to eq(game.map_id)
				expect(game_test.team_id).to eq(game.team_id)
				expect(game_test.champion_id).to eq(game.champion_id)
				expect(game_test.spell1).to eq(game.spell1)
				expect(game_test.spell2).to eq(game.spell2)
				expect(game_test.level).to eq(game.level)
				expect(game_test.ip_earned).to eq(game.ip_earned)
				expect(game_test.create_date).to eq(game.create_date)

				game_test.fellow_players.each_with_index do |fellow_player, i|
					expect(fellow_player.summoner_id).to eq(game.fellow_players[i].summoner_id)
					expect(fellow_player.team_id).to eq(game.fellow_players[i].team_id)
					expect(fellow_player.champion_id).to eq(game.fellow_players[i].champion_id)
				end
				
				expect(game_test.stats.level).to eq(game.stats.level)
				expect(game_test.stats.champions_killed).to eq(game.stats.champions_killed)
				expect(game_test.stats.barracks_killed).to eq(game.stats.barracks_killed)
				expect(game_test.stats.combat_player_score).to eq(game.stats.combat_player_score)
				expect(game_test.stats.consumables_purchased).to eq(game.stats.consumables_purchased)
				expect(game_test.stats.double_kills).to eq(game.stats.double_kills)
				expect(game_test.stats.first_blood).to eq(game.stats.first_blood)
				expect(game_test.stats.gold_earned).to eq(game.stats.gold_earned)
				expect(game_test.stats.gold_spent).to eq(game.stats.gold_spent)
				expect(game_test.stats.item0).to eq(game.stats.item0)
				expect(game_test.stats.item1).to eq(game.stats.item1)
				expect(game_test.stats.item2).to eq(game.stats.item2)
				expect(game_test.stats.item3).to eq(game.stats.item3)
				expect(game_test.stats.item4).to eq(game.stats.item4)
				expect(game_test.stats.item5).to eq(game.stats.item5)
				expect(game_test.stats.item6).to eq(game.stats.item6)
				expect(game_test.stats.items_purchased).to eq(game.stats.items_purchased)
				expect(game_test.stats.killing_sprees).to eq(game.stats.killing_sprees)
				expect(game_test.stats.largest_critical_strike).to eq(game.stats.largest_critical_strike)
				expect(game_test.stats.largest_killing_spree).to eq(game.stats.largest_killing_spree)
				expect(game_test.stats.largest_multi_kill).to eq(game.stats.largest_multi_kill)
				expect(game_test.stats.legendary_items_created).to eq(game.stats.legendary_items_created)
				expect(game_test.stats.magic_damage_dealt_player).to eq(game.stats.magic_damage_dealt_player)
				expect(game_test.stats.magic_damage_dealt_to_champions).to eq(game.stats.magic_damage_dealt_to_champions)
				expect(game_test.stats.magic_damage_taken).to eq(game.stats.magic_damage_taken)
				expect(game_test.stats.minions_denied).to eq(game.stats.minions_denied)
				expect(game_test.stats.minions_killed).to eq(game.stats.minions_killed)
				expect(game_test.stats.neutral_minions_killed).to eq(game.stats.neutral_minions_killed)
				expect(game_test.stats.neutral_minions_killed_enemy_jungle).to eq(game.stats.neutral_minions_killed_enemy_jungle)
				expect(game_test.stats.neutral_minions_killed_your_jungle).to eq(game.stats.neutral_minions_killed_your_jungle)
				expect(game_test.stats.nexus_killed).to eq(game.stats.nexus_killed)
				expect(game_test.stats.node_capture).to eq(game.stats.node_capture)
				expect(game_test.stats.node_capture_assist).to eq(game.stats.node_capture_assist)
				expect(game_test.stats.node_neutralize).to eq(game.stats.node_neutralize)
				expect(game_test.stats.node_neutralize_assist).to eq(game.stats.node_neutralize_assist)
				expect(game_test.stats.num_deaths).to eq(game.stats.num_deaths)
				expect(game_test.stats.num_items_bought).to eq(game.stats.num_items_bought)
				expect(game_test.stats.objective_player_score).to eq(game.stats.objective_player_score)
				expect(game_test.stats.penta_kills).to eq(game.stats.penta_kills)
				expect(game_test.stats.physical_damage_dealt_player).to eq(game.stats.physical_damage_dealt_player)
				expect(game_test.stats.physical_damage_dealt_to_champions).to eq(game.stats.physical_damage_dealt_to_champions)
				expect(game_test.stats.physical_damage_taken).to eq(game.stats.physical_damage_taken)
				expect(game_test.stats.quadra_kills).to eq(game.stats.quadra_kills)
				expect(game_test.stats.sight_wards_bought).to eq(game.stats.sight_wards_bought)
				expect(game_test.stats.spell4_cast).to eq(game.stats.spell4_cast)
				expect(game_test.stats.spell3_cast).to eq(game.stats.spell3_cast)
				expect(game_test.stats.spell2_cast).to eq(game.stats.spell2_cast)
				expect(game_test.stats.spell1_cast).to eq(game.stats.spell1_cast)
				expect(game_test.stats.summon_spell1_cast).to eq(game.stats.summon_spell1_cast)
				expect(game_test.stats.summon_spell2_cast).to eq(game.stats.summon_spell2_cast)
				expect(game_test.stats.super_monster_killed).to eq(game.stats.super_monster_killed)
				expect(game_test.stats.team).to eq(game.stats.team)
				expect(game_test.stats.team_objective).to eq(game.stats.team_objective)
				expect(game_test.stats.time_played).to eq(game.stats.time_played)
				expect(game_test.stats.total_damage_dealt).to eq(game.stats.total_damage_dealt)
				expect(game_test.stats.total_damage_dealt_to_champions).to eq(game.stats.total_damage_dealt_to_champions)
				expect(game_test.stats.total_damage_taken).to eq(game.stats.total_damage_taken)
				expect(game_test.stats.total_heal).to eq(game.stats.total_heal)
				expect(game_test.stats.total_player_score).to eq(game.stats.total_player_score)
				expect(game_test.stats.total_score_rank).to eq(game.stats.total_score_rank)
				expect(game_test.stats.total_time_crowd_control_dealt).to eq(game.stats.total_time_crowd_control_dealt)
				expect(game_test.stats.total_units_healed).to eq(game.stats.total_units_healed)
				expect(game_test.stats.triple_kills).to eq(game.stats.triple_kills)
				expect(game_test.stats.true_damage_dealt_player).to eq(game.stats.true_damage_dealt_player)
				expect(game_test.stats.true_damage_dealt_to_champions).to eq(game.stats.true_damage_dealt_to_champions)
				expect(game_test.stats.true_damage_taken).to eq(game.stats.true_damage_taken)
				expect(game_test.stats.turrets_killed).to eq(game.stats.turrets_killed)
				expect(game_test.stats.unreal_kills).to eq(game.stats.unreal_kills)
				expect(game_test.stats.victory_point_total).to eq(game.stats.victory_point_total)
				expect(game_test.stats.vision_wards_bought).to eq(game.stats.vision_wards_bought)
				expect(game_test.stats.ward_killed).to eq(game.stats.ward_killed)
				expect(game_test.stats.ward_placed).to eq(game.stats.ward_placed)
				expect(game_test.stats.win).to eq(game.stats.win)
			end
		end

	end

	describe "get_champion_by_id" do

		before(:each) do
			# Create client
			client = FactoryGirl.build(:client)
			id_champion = 412

			api_response = File.read 'spec/mock_response/get_champion_by_id.json'
			stub_request(:get, "https://prod.api.pvp.net/api/lol/static-data/euw/v1.2/champion/#{id_champion}?local=fr_FR&api_key=#{RiotLolApi::TOKEN}").to_return(api_response)

			@champion_test = client.get_champion_by_id(id_champion)
		end

		it "should get summoner object" do
			expect(@champion_test).to be_a RiotLolApi::Model::Champion
		end

		it "should have good attributes" do
			champion = FactoryGirl.build(:champion)

			expect(@champion_test.id).to eq(champion.id)
			expect(@champion_test.key).to eq(champion.key)
			expect(@champion_test.name).to eq(champion.name)
			expect(@champion_test.title).to eq(champion.title)
		end
	end

	describe "get_champion_by_id_all_data" do

		before(:each) do
			# Create client
			client = FactoryGirl.build(:client)
			id_champion = 412

			api_response = File.read 'spec/mock_response/get_champion_by_id_all_data.json'
			stub_request(:get, "https://prod.api.pvp.net/api/lol/static-data/euw/v1.2/champion/#{id_champion}?local=fr_FR&champData=all&api_key=#{RiotLolApi::TOKEN}").to_return(api_response)

			@champion_test = client.get_champion_by_id(id_champion,{:champData => 'all'})
		end

		it "should get summoner object" do
			expect(@champion_test).to be_a RiotLolApi::Model::Champion
		end

		it "should have good attributes" do
			champion = FactoryGirl.build(:champion)

			expect(@champion_test.id).to eq(champion.id)
			expect(@champion_test.key).to eq(champion.key)
			expect(@champion_test.name).to eq(champion.name)
			expect(@champion_test.title).to eq(champion.title)
		end
	end

end