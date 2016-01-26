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
      include RiotLolApi::Concern::Init
    end
  end
end
