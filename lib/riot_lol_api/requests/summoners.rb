module RiotLolApi
  module Request
    module Summoner
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
    end
  end
end
