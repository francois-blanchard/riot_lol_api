require 'riot_lol_api/model/player_stat_summary'
require 'riot_lol_api/model/player_stat_rank'
require 'riot_lol_api/model/page'
require 'riot_lol_api/model/game'
require 'riot_lol_api/model/league'

module RiotLolApi
  module Model
	class Summoner

		# attr needs @id, @region
		SEASON_TAB = %Q{SEASON4,SEASON3}
		def initialize(options = {})
			options.each do |key, value|
				self.class.send(:attr_accessor, key.to_sym)
				instance_variable_set("@#{key}", value)
			end
		end

		def masteries
			response = Client.get("#{@region}/v1.4/summoner/#{@id}/masteries",@region)
			unless response.nil?
				tab_pages = Array.new
				response[self.id.to_s]['pages'].each do |page|
					tab_pages << RiotLolApi::Model::Page.new(page.to_symbol.merge({:region => @region}))
				end
				tab_pages
			else
				nil
			end
		end

		def runes
			response = Client.get("#{@region}/v1.4/summoner/#{@id}/runes", @region)
			unless response.nil?
				tab_pages = Array.new
				response[self.id.to_s]['pages'].each do |page|
					tab_pages << RiotLolApi::Model::Page.new(page.to_symbol)
				end
				tab_pages
			else
				nil
			end
		end

		def games
			response = Client.get("#{@region}/v1.3/game/by-summoner/#{@id}/recent", @region)
			unless response.nil?
				games = response['games']

				tab_games = Array.new
				games.each do |game|
					tab_games << RiotLolApi::Model::Game.new(game.to_symbol)
				end

				tab_games
			else
				nil
			end
		end

		def stat_summaries season="SEASON4"
			response = Client.get("#{@region}/v1.3/stats/by-summoner/#{@id}/summary",@region,{:season => season})
			unless response.nil?
				stat_summaries = response['playerStatSummaries']

				tab_stat_summaries = Array.new
				stat_summaries.each do |stat_summary|
					tab_stat_summaries << RiotLolApi::Model::PlayerStatSummary.new(stat_summary.to_symbol)
				end

				tab_stat_summaries
			else
				nil
			end
		end

		def stat_ranks season="SEASON4"
			response = Client.get("#{@region}/v1.3/stats/by-summoner/#{@id}/ranked",@region,{:season => season})
			unless response.nil?
				stat_ranks = response['champions']

				tab_stat_ranks = Array.new
				stat_ranks.each do |stat_rank|
					tab_stat_ranks << RiotLolApi::Model::PlayerStatRank.new(stat_rank.to_symbol)
				end

				tab_stat_ranks
			else
				nil
			end
		end

		def get_league_stats
			response = Client.get("#{@region}/v2.4/league/by-summoner/#{@id}/entry",@region)
			unless response.nil?
				league_stats = response["#{@id}"]
				
				tab_league_stats = Array.new
				league_stats.each do |league_stat|
					tab_league_stats << RiotLolApi::Model::League.new(league_stat.to_symbol)
				end

				tab_league_stats
			else
				nil
			end
		end
	end
  end
end