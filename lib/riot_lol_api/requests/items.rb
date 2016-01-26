module RiotLolApi
  module Request
    module Item
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
    end
  end
end
