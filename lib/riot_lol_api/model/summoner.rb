module RiotLolApi
  module Model
	class Summoner

		def initialize(options = {})
			options.each do |key, value|
				self.class.send(:attr_accessor, key.to_sym)
				instance_variable_set("@#{key}", value)
			end
		end

		def masteries
			response = Client.get("https://prod.api.pvp.net/api/lol/#{@region}/v1.4/summoner/#{@id}/masteries")
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

		def runes
			response = Client.get("https://prod.api.pvp.net/api/lol/#{@region}/v1.4/summoner/#{@id}/runes")
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
			response = Client.get("https://prod.api.pvp.net/api/lol/#{@region}/v1.3/game/by-summoner/#{@id}/recent")
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

	end
  end
end