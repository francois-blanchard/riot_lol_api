require 'riot_lol_api/models/golds'
require 'riot_lol_api/models/effects'
require 'riot_lol_api/models/maps'

module RiotLolApi
  module Model
    class Item
      include RiotLolApi::Concern::Init
    end
  end
end
