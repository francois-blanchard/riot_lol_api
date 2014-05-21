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

		def self.get url
			unless RiotLolApi::TOKEN.nil?
				response = HTTParty.get(url, :query => {:api_key => RiotLolApi::TOKEN})
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

		def get_summoner_by_name name
			name = name.downcase
			name.strip!
			response = Client.get("https://prod.api.pvp.net/api/lol/#{@region}/v1.4/summoner/by-name/#{name}")
			unless response.nil?
				summoner = response[name]
				RiotLolApi::Model::Summoner.new(:id_summoner => summoner["id"],:name => summoner["name"],:profile_icon_id => summoner["profileIconId"],:summoner_level => summoner["summonerLevel"],:revision_date_str => '',:revision_date => summoner["revisionDate"],:region => @region)
			else
				nil
			end
		end

		def get_summoner_by_id id
			response = Client.get("https://prod.api.pvp.net/api/lol/#{@region}/v1.4/summoner/#{id}")
			unless response.nil?
				summoner = response[id.to_s]
				RiotLolApi::Model::Summoner.new(:id_summoner => summoner["id"],:name => summoner["name"],:profile_icon_id => summoner["profileIconId"],:summoner_level => summoner["summonerLevel"],:revision_date_str => '',:revision_date => summoner["revisionDate"],:region => @region)
			else
				nil
			end
		end

	end
end