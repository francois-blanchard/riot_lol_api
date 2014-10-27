require 'riot_lol_api/model/stats'
require 'riot_lol_api/model/recommendeds'
require 'riot_lol_api/model/images'
require 'riot_lol_api/model/spells'
require 'riot_lol_api/model/infos'
require 'riot_lol_api/model/passives'
require 'riot_lol_api/model/skins'
require 'riot_lol_api/model/data'

module RiotLolApi
  module Model
    class Champion

      def initialize(options = {})
        options.each do |key, value|
          self.class.send(:attr_accessor, key.to_sym)
          instance_variable_set("@#{key}", value)
        end
      end

    end
  end
end
