require 'riot_lol_api/models/stats'
require 'riot_lol_api/models/recommendeds'
require 'riot_lol_api/models/images'
require 'riot_lol_api/models/spells'
require 'riot_lol_api/models/infos'
require 'riot_lol_api/models/passives'
require 'riot_lol_api/models/skins'
require 'riot_lol_api/models/data'

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
