require 'httparty'
require 'json'

module RiotLolApi
	class Client

		include RiotLolApi::HelperClass

		# Constant URL
		BASE_URL_API = "api.pvp.net/api/lol/"

		# attr
		# - region
		def initialize(options = {})
			options.each do |key, value|
				self.class.send(:attr_accessor, key.to_sym)
				instance_variable_set("@#{key}", value)
			end
			if RiotLolApi::Client.realm.nil? && !self.region.nil?
				self.get_realm
			end
		end

		class << self
			attr_accessor :realm
		end

		def get_realm
			response = Client.get("static-data/#{self.region}/v1.2/realm", "global")
			unless response.nil?
				self.class.realm = response
			else
				nil
			end
		end

		# TO DO
		# Set callback to get realm constants
		#

		def self.get url, domaine,data = nil, overide_base_uri = nil
			unless RiotLolApi::TOKEN.nil?

				# Check limit rate
				# RiotLolApi::RATE_LIMIT += 1
				# if Time.now - RiotLolApi::RATE_LIMIT_RESET_DATE > RiotLolApi::RATE_LIMIT_SEC_MAX
				# 	RiotLolApi::RATE_LIMIT_RESET_DATE = Time.now
				# else
				# 	if RiotLolApi::RATE_LIMIT == RiotLolApi::RATE_LIMIT_REQ_MAX
				# end

				# Set data params
				if data.nil?
					data = {:api_key => RiotLolApi::TOKEN}
				else
					data.merge!({:api_key => RiotLolApi::TOKEN})
				end

				# Set domaine url
				domaine_url = "#{domaine}.#{overide_base_uri||BASE_URL_API}"
				response = HTTParty.get("https://#{domaine_url}#{url}", :query => data)
				case response.code
					when 200
						JSON.parse(response.body)
					when 404
						puts "Error server"
						nil
					when 500...600
						puts "ERROR #{response.code}"
						nil
				end
			else
				puts "No TOKEN, you have to define RiotLolApi::TOKEN"
				nil
			end
		end

		# SUMMONER

		def get_summoner_by_name name
			name = name.downcase
			name.strip!
			response = Client.get("#{@region}/v1.4/summoner/by-name/#{name}",@region)
			unless response.nil?
				RiotLolApi::Model::Summoner.new(response[name].to_symbol.merge({:region => @region}))
			else
				nil
			end
		end

		def get_summoner_by_id id
			response = Client.get("#{@region}/v1.4/summoner/#{id}",@region)
			unless response.nil?
				RiotLolApi::Model::Summoner.new(response[id.to_s].to_symbol.merge({:region => @region}))
			else
				nil
			end
		end

		def get_summoners_by_id id
			response = Client.get("#{@region}/v1.4/summoner/#{id}",@region)
			unless response.nil?
				summoners = Array.new
				response.each do |id, data|
					summoners << RiotLolApi::Model::Summoner.new(response[data['id'].to_s].to_symbol.merge({:region => @region}))
				end
				summoners
			else
				nil
			end
		end

		def get_summoners_by_name name
			response = Client.get("#{@region}/v1.4/summoner/by-name/#{name}",@region)
			unless response.nil?
				summoners = Array.new
				response.each do |name, data|
					#downcase and gsub are to handle capital letters and spaces in summoner names. If this method breaks this is a good place to check for errors.
					summoners << RiotLolApi::Model::Summoner.new(response[data['name'].downcase.gsub(' ', '').to_s].to_symbol.merge({:region => @region}))
				end
				summoners
			else
				nil
			end
		end

		# CHAMPION

		def get_champion_by_id id, data = nil, locale = 'en_US'
			if data.nil?
				data = {:locale => locale}
			else
				data.merge!({:locale => locale})
			end

			response = Client.get("static-data/#{@region}/v1.2/champion/#{id}","global",data)
			unless response.nil?
				RiotLolApi::Model::Champion.new(response.to_symbol)
			else
				nil
			end
		end

		def get_all_champions data = nil, sort_id = 'false', locale = 'en_US'
			if data.nil?
				data = {:locale => locale, :dataById => sort_id}
			else
				data.merge!({:locale => locale, :dataById => sort_id})
			end

			response = Client.get("static-data/#{@region}/v1.2/champion","global",data)
			unless response.nil?
				tab_champions = Array.new
				response["data"].each do |champion|
					tab_champions << RiotLolApi::Model::Champion.new(champion[1].to_symbol)
				end
				tab_champions
			else
				nil
			end
		end

		# ITEM

		def get_all_items data = nil, locale = 'en_US'
			if data.nil?
				data = {:locale => locale}
			else
				data.merge!({:locale => locale})
			end

			response = Client.get("static-data/#{@region}/v1.2/item","global",data)
			unless response.nil?
				tab_items = Array.new
				response["data"].each do |item|
					tab_items << RiotLolApi::Model::Item.new(item[1].to_symbol)
				end
				tab_items
			else
				nil
			end
		end

		def get_item_by_id id, data = nil, locale = 'en_US'
			if data.nil?
				data = {:locale => locale}
			else
				data.merge!({:locale => locale})
			end

			response = Client.get("static-data/#{@region}/v1.2/item/#{id}","global",data)
			unless response.nil?
				RiotLolApi::Model::Item.new(response.to_symbol)
			else
				nil
			end
		end

		# MASTERY

		def get_all_masteries data = nil, locale = 'en_US'
			if data.nil?
				data = {:locale => locale}
			else
				data.merge!({:locale => locale})
			end

			response = Client.get("static-data/#{@region}/v1.2/mastery","global",data)
			unless response.nil?
				tab_masteries = Array.new
				response["data"].each do |mastery|
					tab_masteries << RiotLolApi::Model::Mastery.new(mastery[1].to_symbol)
				end
				tab_masteries
			else
				nil
			end
		end

		def get_mastery_by_id id, data = nil, locale = 'en_US'
			if data.nil?
				data = {:locale => locale}
			else
				data.merge!({:locale => locale})
			end

			response = Client.get("static-data/#{@region}/v1.2/mastery/#{id}","global",data)
			unless response.nil?
				RiotLolApi::Model::Mastery.new(response.to_symbol)
			else
				nil
			end
		end

		# RUNE

		def get_all_runes data = nil, locale = 'en_US'
			if data.nil?
				data = {:locale => locale}
			else
				data.merge!({:locale => locale})
			end

			response = Client.get("static-data/#{@region}/v1.2/rune","global",data)
			unless response.nil?
				tab_runes = Array.new
				response["data"].each do |rune|
					tab_runes << RiotLolApi::Model::Rune.new(rune[1].to_symbol)
				end
				tab_runes
			else
				nil
			end
		end

		def get_rune_by_id id, data = nil, locale = 'en_US'
			if data.nil?
				data = {:locale => locale}
			else
				data.merge!({:locale => locale})
			end

			response = Client.get("static-data/#{@region}/v1.2/rune/#{id}","global",data)
			unless response.nil?
				RiotLolApi::Model::Rune.new(response.to_symbol)
			else
				nil
			end
		end

		# SUMMONER SPELL

		def get_all_summoner_spells data = nil, sort_id = 'false', locale = 'en_US'
			if data.nil?
				data = {:locale => locale, :dataById => sort_id}
			else
				data.merge!({:locale => locale, :dataById => sort_id})
			end

			response = Client.get("static-data/#{@region}/v1.2/summoner-spell","global",data)
			unless response.nil?
				tab_summoner_spells = Array.new
				response["data"].each do |summoner_spell|
					tab_summoner_spells << RiotLolApi::Model::Spell.new(summoner_spell[1].to_symbol)
				end
				tab_summoner_spells
			else
				nil
			end
		end

		def get_summoner_spell_by_id id, data = nil, locale = 'en_US'
			if data.nil?
				data = {:locale => locale}
			else
				data.merge!({:locale => locale})
			end

			response = Client.get("static-data/#{@region}/v1.2/summoner-spell/#{id}","global",data)
			unless response.nil?
				RiotLolApi::Model::Spell.new(response.to_symbol)
			else
				nil
			end
		end

		def featured_games
			response = Client.get("observer-mode/rest/featured",@region,nil,'api.pvp.net/')
			unless response.nil?
				RiotLolApi::Model::Observer.new(response.to_symbol)
			else
				nil
			end
		end

		def current_game summoner_id, platform_id='EUW1'
			response = Client.get("observer-mode/rest/consumer/getSpectatorGameInfo/#{platform_id}/#{summoner_id}",@region,nil,'api.pvp.net/')
			unless response.nil?
				RiotLolApi::Model::Game.new(response.to_symbol)
			else
				nil
			end
		end

		def match game_id
			response = Client.get("#{@region}/v2.2/match/#{game_id}",@region)
			unless response.nil?
				RiotLolApi::Model::Match.new(response.to_symbol)
			else
				nil
			end
		end

		def get_versions
			response = Client.get("static-data/#{@region}/v1.2/versions","global")
			unless response.nil?
				response
			else
				nil
			end
		end

	end
end
