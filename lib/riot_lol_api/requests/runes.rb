module RiotLolApi
  module Request
    module Rune
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
    end
  end
end
