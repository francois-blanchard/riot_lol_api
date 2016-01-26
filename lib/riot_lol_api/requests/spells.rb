module RiotLolApi
  module Request
    module Spell
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
    end
  end
end
