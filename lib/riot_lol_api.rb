require 'riot_lol_api/version'
require 'riot_lol_api/helper_classes'
require 'riot_lol_api/clients'
require 'riot_lol_api/models'
require 'core_ext/string/riot_lol_api'
require 'core_ext/hash/riot_lol_api'
require 'riot_lol_api/model/class_base'

Hash.include CoreExt::Hash::RiotLolApi
String.include CoreExt::String::RiotLolApi

module RiotLolApi
  # # http://ddragon.leagueoflegends.com/tool/euw/fr_FR
  # RiotLolApi::RATE_LIMIT = 0
  # RiotLolApi::RATE_LIMIT_REQ_MAX = 10
  # RiotLolApi::RATE_LIMIT_SEC_MAX = 10
  # RiotLolApi::RATE_LIMIT_RESET_DATE = Time.now
end
