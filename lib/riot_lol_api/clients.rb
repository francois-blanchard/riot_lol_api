require 'httparty'
require 'json'

module RiotLolApi
  class Client
    include RiotLolApi::HelperClass

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

    def get(url:, domaine:, data: {}, overide_base_uri: BASE_URL_API)
      return fail('need api key') if @api_key.nil?
      data.merge!(api_key: @api_key)
      domaine_url = "#{domaine}.#{overide_base_uri}"
      response = HTTParty.get("https://#{domaine_url}#{url}", query: data)
      return JSON.parse(response.body) if response.code == 200
      nil
    end

    # SUMMONER

    def get_summoner_by_name(name)
      name = name.downcase
      name.strip!
      response = get(url: "#{@region}/v1.4/summoner/by-name/#{name}", domaine: @region)
      return nil if response.nil?
      RiotLolApi::Model::Summoner.new(response[name].lol_symbolize.merge(region: @region, client: self))
    end

    def get_summoner_by_id(id)
      response = get(url: "#{@region}/v1.4/summoner/#{id}", domaine: @region)
      return nil if response.nil?
      RiotLolApi::Model::Summoner.new(response[id.to_s].lol_symbolize.merge(region: @region, client: self))
    end

    def get_summoners_by_id(id)
      response = get(url: "#{@region}/v1.4/summoner/#{id}", domaine: @region)
      return nil if response.nil?
      summoners = []
      response.each do |_id, data|
        summoners << RiotLolApi::Model::Summoner.new(response[data['id'].to_s].lol_symbolize.merge(region: @region, client: self))
      end
      summoners
    end

    # CHAMPION

    def get_champion_by_id(id, data = {}, locale = 'en_US')
      data.merge!(locale: locale)
      response = get(url: "static-data/#{@region}/v1.2/champion/#{id}", domaine: 'global', data: data)
      return nil if response.nil?
      RiotLolApi::Model::Champion.new(response.lol_symbolize)
    end

    def get_all_champions(data = {}, sort_id = 'false', locale = 'en_US')
      data.merge!(locale: locale, dataById: sort_id)
      response = get(url: "static-data/#{@region}/v1.2/champion", domaine: 'global', data: data)
      return nil if response.nil?
      tab_champions = []
      response['data'].each do |champion|
        tab_champions << RiotLolApi::Model::Champion.new(champion[1].lol_symbolize)
      end
      tab_champions
    end

    # ITEM

    def get_all_items(data = {}, locale = 'en_US')
      data.merge!(locale: locale)
      response = get(url: "static-data/#{@region}/v1.2/item", domaine: 'global', data: data)
      return nil if response.nil?
      tab_items = []
      response['data'].each do |item|
        tab_items << RiotLolApi::Model::Item.new(item[1].lol_symbolize)
      end
      tab_items
    end

    def get_item_by_id(id, data = {}, locale = 'en_US')
      data.merge!(locale: locale)
      response = get(url: "static-data/#{@region}/v1.2/item/#{id}", domaine: 'global', data: data)
      return nil if response.nil?
      RiotLolApi::Model::Item.new(response.lol_symbolize)
    end

    # MASTERY

    def get_all_masteries(data = nil, locale = 'en_US')
      data.merge!(locale: locale)
      response = get(url: "static-data/#{@region}/v1.2/mastery", domaine: 'global', data: data)
      return nil if response.nil?
      tab_masteries = []
      response['data'].each do |mastery|
        tab_masteries << RiotLolApi::Model::Mastery.new(mastery[1].lol_symbolize.merge(client: self))
      end
      tab_masteries
    end

    def get_mastery_by_id(id, data = {}, locale = 'en_US')
      data.merge!(locale: locale)
      response = get(url: "static-data/#{@region}/v1.2/mastery/#{id}", domaine: 'global', data: data)
      return nil if response.nil?
      RiotLolApi::Model::Mastery.new(response.lol_symbolize.merge(client: self))
    end

    # RUNE

    def get_all_runes(data = {}, locale = 'en_US')
      data.merge!(locale: locale)
      response = get(url: "static-data/#{@region}/v1.2/rune", domaine: 'global', data: data)
      return nil if response.nil?
      tab_runes = []
      response['data'].each do |rune|
        tab_runes << RiotLolApi::Model::Rune.new(rune[1].lol_symbolize)
      end
      tab_runes
    end

    def get_rune_by_id(id, data = {}, locale = 'en_US')
      data.merge!(locale: locale)
      response = get(url: "static-data/#{@region}/v1.2/rune/#{id}", domaine: 'global', data: data)
      return nil if response.nil?
      RiotLolApi::Model::Rune.new(response.lol_symbolize)
    end

    # SUMMONER SPELL

    def get_all_summoner_spells(data = {}, sort_id = 'false', locale = 'en_US')
      data.merge!(locale: locale, dataById: sort_id)
      response = get(url: "static-data/#{@region}/v1.2/summoner-spell", domaine: 'global', data: data)
      return nil if response.nil?
      tab_summoner_spells = []
      response['data'].each do |summoner_spell|
        tab_summoner_spells << RiotLolApi::Model::Spell.new(summoner_spell[1].lol_symbolize)
      end
      tab_summoner_spells
    end

    def get_summoner_spell_by_id(id, data = {}, locale = 'en_US')
      data.merge!(locale: locale)
      response = get(url: "static-data/#{@region}/v1.2/summoner-spell/#{id}", domaine: 'global', data: data)
      return nil if response.nil?
      RiotLolApi::Model::Spell.new(response.lol_symbolize)
    end

    def featured_games
      response = get(url: 'observer-mode/rest/featured', domaine: @region, overide_base_uri: 'api.pvp.net/')
      return nil if response.nil?
      RiotLolApi::Model::Observer.new(response.lol_symbolize)
    end

    def current_game(summoner_id, platform_id = 'EUW1')
      response = get(url: "observer-mode/rest/consumer/getSpectatorGameInfo/#{platform_id}/#{summoner_id}", domaine: @region, overide_base_uri: 'api.pvp.net/')
      return nil if response.nil?
      RiotLolApi::Model::Game.new(response.lol_symbolize)
    end

    def match(game_id)
      response = get(url: "#{@region}/v2.2/match/#{game_id}", domaine: @region)
      return nil if response.nil?
      RiotLolApi::Model::Match.new(response.lol_symbolize)
    end

    def versions
      get(url: "static-data/#{@region}/v1.2/versions", domaine: 'global')
    end
  end
end
