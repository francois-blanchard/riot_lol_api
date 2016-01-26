module RiotLolApi
  module Request
    module Mastery
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
    end
  end
end
