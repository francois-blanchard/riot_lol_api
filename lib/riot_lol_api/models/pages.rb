require 'riot_lol_api/models/masteries'
require 'riot_lol_api/models/slots'
require 'riot_lol_api/models/runes'

module RiotLolApi
  module Model
    class Page
      include RiotLolApi::Concern::Init
    end
  end
end
