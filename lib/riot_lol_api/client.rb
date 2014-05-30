require 'httparty'
require 'json'

module RiotLolApi
	class Client

		# attr
		# - region
		def initialize(options = {})
			options.each do |key, value|
				self.class.send(:attr_accessor, key.to_sym)
				instance_variable_set("@#{key}", value)
			end
		end

		def self.get url, data = nil
			unless RiotLolApi::TOKEN.nil?
				if data.nil?
					data = {:api_key => RiotLolApi::TOKEN}
				else
					data.merge!({:api_key => RiotLolApi::TOKEN})
				end
				response = HTTParty.get(url, :query => data)
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
			response = Client.get("https://prod.api.pvp.net/api/lol/#{@region}/v1.4/summoner/by-name/#{name}")
			unless response.nil?
				RiotLolApi::Model::Summoner.new(response[name].to_symbol.merge({:region => @region}))
			else
				nil
			end
		end

		def get_summoner_by_id id
			response = Client.get("https://prod.api.pvp.net/api/lol/#{@region}/v1.4/summoner/#{id}")
			unless response.nil?
				RiotLolApi::Model::Summoner.new(response[id.to_s].to_symbol.merge({:region => @region}))
			else
				nil
			end
		end

		# CHAMPION

		def get_champion_by_id id, data = nil, local = 'fr_FR'
			if data.nil?
				data = {:local => local}
			else
				data.merge!({:local => local})
			end
			
	        response = Client.get("https://prod.api.pvp.net/api/lol/static-data/#{@region}/v1.2/champion/#{id}",data)
	        unless response.nil?
				RiotLolApi::Model::Champion.new(response.to_symbol)
	        else
				nil
	        end
	    end

	end
end