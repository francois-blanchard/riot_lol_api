module RiotLolApi
  module Model
	class Summoner

		# attr :id_summoner, :name, :profile_icon_id, :summoner_level, :revision_date_str, :revision_date, :region

		def initialize(options = {})
			options.each do |key, value|
				self.class.send(:attr_accessor, key.to_sym)
				instance_variable_set("@#{key}", value)
			end
		end

		def masteries
			response = Client.get("https://prod.api.pvp.net/api/lol/#{@region}/v1.4/summoner/#{@id_summoner}/masteries")
			unless response.nil?
				masteries = response[self.id_summoner.to_s]['pages']
				# masteries
				tab_masteries = Array.new
				masteries.each do |mastery|
					# talents
					tab_talents = Array.new
					unless mastery['masteries'].nil?
						mastery['masteries'].each do |talent|
							tab_talents << RiotLolApi::Model::Talent.new(:id_talent => talent['id'], :rank => talent['rank'])
						end
					end
					tab_masteries << RiotLolApi::Model::Mastery.new(:id_mastery => mastery["id"], :name => mastery["name"], :current => mastery["current"], :talents => tab_talents)
				end
				tab_masteries
			else
				nil
			end
		end

		def runes
			response = Client.get("https://prod.api.pvp.net/api/lol/#{@region}/v1.4/summoner/#{@id_summoner}/runes")
			unless response.nil?
				runes = response[self.id_summoner.to_s]['pages']
				# runes
				tab_runes = Array.new
				runes.each do |rune|
					# talents
					tab_slots = Array.new
					unless rune['slots'].nil?
						rune['slots'].each do |slot|
							tab_slots << RiotLolApi::Model::Slot.new(:id_slot => slot['runeId'], :rank => slot['runeSlotId'])
						end
					end
					tab_runes << RiotLolApi::Model::Rune.new(:id_rune => rune["id"], :name => rune["name"], :current => rune["current"], :slots => tab_slots)
				end

				tab_runes
			else
				nil
			end
		end

		def games
			response = Client.get("https://prod.api.pvp.net/api/lol/#{@region}/v1.3/game/by-summoner/#{@id_summoner}/recent")
			unless response.nil?
				games = response['games']

				tab_games = Array.new
				games.each do |game|

					tab_fellow_players = Array.new
					game['fellowPlayers'].each do |fellow_player|
						tab_fellow_players << RiotLolApi::Model::Player.new(:summoner_id => fellow_player['summonerId'], :team_id => fellow_player['teamId'], :champion_id => fellow_player['championId'])
					end

					stat = game['stats']
					tab_stats = RiotLolApi::Model::Stat.new(:nexus_killed => stat['nexusKilled'] || false, :neutral_minions_killed_your_jungle => stat['neutralMinionsKilledYourJungle'] || 0,:neutral_minions_killed_enemy_jungle => stat['neutralMinionsKilledEnemyJungle'] || 0,:neutral_minions_killed => stat['neutralMinionsKilled'] || 0, :minions_denied => stat['minionsDenied'] || 0,:largest_killing_spree => stat['largestKillingSpree'],:largest_multi_kill => stat['largestMultiKill'],:legendary_items_created => stat['legendaryItemsCreated'],:largest_critical_strike => stat['largestCriticalStrike'],:killing_sprees => stat['killingSprees'] || 0, :items_purchased => stat['itemsPurchased'] || 0, :first_blood => stat['firstBlood'], :double_kills => stat['doubleKills'], :consumables_purchased => stat['consumablesPurchased'], :combat_player_score => stat['combatPlayerScore'] || 0, :champions_killed => stat['championsKilled'] || 0, :barracks_killed => stat['barracksKilled'] || 0, :total_damage_dealt_to_champions => stat['totalDamageDealtToChampions'], :gold_earned => stat['goldEarned'], :item2 => stat['item2'], :item1 => stat['item1'], :ward_placed => stat['wardPlaced'], :total_damage_taken => stat['totalDamageTaken'], :item0 => stat['item0'], :physical_damage_dealt_player => stat['physicalDamageDealtPlayer'], :total_units_healed => stat['totalUnitsHealed'], :level => stat['level'], :magic_damage_dealt_to_champions => stat['magicDamageDealtToChampions'], :magic_damage_dealt_player => stat['magicDamageDealtPlayer'], :assists => stat['assists'], :magic_damage_taken => stat['magicDamageTaken'], :num_deaths => stat['numDeaths'], :total_time_crowd_control_dealt => stat['totalTimeCrowdControlDealt'], :physical_damage_taken => stat['physicalDamageTaken'], :win => stat['win'], :team => stat['team'], :sight_wards_bought => stat['sightWardsBought'], :total_damage_dealt => stat['totalDamageDealt'], :total_heal => stat['totalHeal'], :item4 => stat['item4'], :item3 => stat['item3'], :item6 => stat['item6'], :item5 => stat['item5'], :minions_killed => stat['minionsKilled'], :time_played => stat['timePlayed'], :physical_damage_dealt_to_champions => stat['physicalDamageDealtToChampions'], :true_damage_taken => stat['trueDamageTaken'], :gold_spent => stat['goldSpent'])

					# nodeCapture

					tab_games << RiotLolApi::Model::Game.new(:champion_id => game['championId'], :invalid => game['invalid'], :ip_earned => game['ipEarned'], :create_date => game['createDate'], :create_date_str => '', :fellow_players => tab_fellow_players, :game_id => game['gameId'], :game_mode => game['gameMode'], :game_type => game['gameType'], :level => game['level'], :map_id => game['mapId'], :spell1 => game['spell1'], :spell2 => game['spell2'], :stats => tab_stats, :sub_type => game['subType'], :team_id => game['teamId'])
				end

				tab_games
			else
				nil
			end
		end

	end
  end
end