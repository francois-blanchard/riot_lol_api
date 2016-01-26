require 'riot_lol_api/models/leveltips'
require 'riot_lol_api/models/images'
require 'riot_lol_api/models/vars'
require 'riot_lol_api/models/altimages'

module RiotLolApi
  module Model
    class Spell
      include RiotLolApi::Concern::Init
    end
  end
end
