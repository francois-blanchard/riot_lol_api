require 'httparty'
require 'json'

module RiotLolApi
	class Client
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

		def self.get url, domaine,data = nil
			unless RiotLolApi::TOKEN.nil?
				# Set data params
				if data.nil?
					data = {:api_key => RiotLolApi::TOKEN}
				else
					data.merge!({:api_key => RiotLolApi::TOKEN})
				end

				# Set domaine url
				domaine_url = "#{domaine}.#{BASE_URL_API}"

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

		# CHAMPION

		def get_champion_by_id id, data = nil, locale = 'fr_FR'
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

		def get_all_champions data = nil, sort_id = 'false', locale = 'fr_FR'
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
		
		def get_all_items data = nil, locale = 'fr_FR'
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
	end
end