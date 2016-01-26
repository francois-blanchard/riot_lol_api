require 'httparty'
require 'json'
require 'riot_lol_api/requests/summoners'
require 'riot_lol_api/requests/champions'
require 'riot_lol_api/requests/items'
require 'riot_lol_api/requests/masteries'
require 'riot_lol_api/requests/runes'
require 'riot_lol_api/requests/spells'
require 'riot_lol_api/requests/games'

module RiotLolApi
  class Client
    include RiotLolApi::HelperClass
    include RiotLolApi::Request::Summoner
    include RiotLolApi::Request::Champion
    include RiotLolApi::Request::Item
    include RiotLolApi::Request::Mastery
    include RiotLolApi::Request::Rune
    include RiotLolApi::Request::Spell
    include RiotLolApi::Request::Game

    BASE_URL_API = 'api.pvp.net/api/lol/'

    attr_accessor :region, :api_key

    def initialize(options = {})
      options.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
      yield(self) if block_given?
      realm if RiotLolApi::Client.realm.nil? && !region.nil?
    end

    class << self
      attr_accessor :realm
    end

    def realm
      response = get(url: "static-data/#{region}/v1.2/realm", domaine: 'global')
      self.class.realm = response unless response.nil?
    end

    def versions
      get(url: "static-data/#{@region}/v1.2/versions", domaine: 'global')
    end

    def get(url:, domaine:, data: {}, overide_base_uri: BASE_URL_API)
      return fail('need api key') if @api_key.nil?
      data.merge!(api_key: @api_key)
      domaine_url = "#{domaine}.#{overide_base_uri}"
      response = HTTParty.get("https://#{domaine_url}#{url}", query: data)
      return JSON.parse(response.body) if response.code == 200
      nil
    end
  end
end
