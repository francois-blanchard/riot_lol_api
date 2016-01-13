# Params
API_KEY = ARGV[0]

# Tab files
TAB_CALLS = [
  # game-v1.3
  {
    url: 'euw.api.pvp.net/api/lol/euw/v1.3/game/by-summoner/20639710/recent',
    filename: 'get_summoner_games_by_id',
    params: nil
  },
  # league-v2.5
  {
    url: 'euw.api.pvp.net/api/lol/euw/v2.5/league/by-summoner/20639710/entry',
    filename: 'get_player_league',
    params: nil
  },
  # lol-static-data-v1.2
  {
    url: 'global.api.pvp.net/api/lol/static-data/euw/v1.2/champion',
    filename: 'get_all_champions_by_ids',
    params: {
      locale: 'fr_FR'
    }
  },
  {
    url: 'global.api.pvp.net/api/lol/static-data/euw/v1.2/champion',
    filename: 'get_all_champions_by_ids_all_data',
    params: {
      locale: 'fr_FR',
      champData: 'all'
    }
  },
  {
    url: 'global.api.pvp.net/api/lol/static-data/euw/v1.2/champion/412',
    filename: 'get_champion_by_id',
    params: {
      locale: 'fr_FR'
    }
  },
  {
    url: 'global.api.pvp.net/api/lol/static-data/euw/v1.2/champion/412',
    filename: 'get_champion_by_id_all_data',
    params: {
      locale: 'fr_FR',
      champData: 'all'
    }
  },
  {
    url: 'global.api.pvp.net/api/lol/static-data/euw/v1.2/item',
    filename: 'get_all_item',
    params: {
      locale: 'fr_FR',
      itemListData: 'all'
    }
  },
  {
    url: 'global.api.pvp.net/api/lol/static-data/euw/v1.2/item/2009',
    filename: 'get_item_by_id',
    params: {
      locale: 'fr_FR',
      itemData: 'all'
    }
  },
  {
    url: 'global.api.pvp.net/api/lol/static-data/euw/v1.2/mastery',
    filename: 'get_all_masteries',
    params: {
      locale: 'fr_FR',
      masteryListData: 'all'
    }
  },
  {
    url: 'global.api.pvp.net/api/lol/static-data/euw/v1.2/mastery/6363',
    filename: 'get_mastery_by_id',
    params: {
      locale: 'fr_FR',
      masteryData: 'all'
    }
  },
  {
    url: 'global.api.pvp.net/api/lol/static-data/euw/v1.2/realm',
    filename: 'realm',
    params: nil
  },
  {
    url: 'global.api.pvp.net/api/lol/static-data/euw/v1.2/rune',
    filename: 'get_all_runes',
    params: {
      locale: 'fr_FR',
      runeListData: 'all'
    }
  },
  {
    url: 'global.api.pvp.net/api/lol/static-data/euw/v1.2/rune/5235',
    filename: 'get_rune_by_id',
    params: {
      locale: 'fr_FR',
      runeData: 'all'
    }
  },
  {
    url: 'global.api.pvp.net/api/lol/static-data/euw/v1.2/summoner-spell',
    filename: 'get_all_summoner_spells',
    params: {
      locale: 'fr_FR',
      dataById: 'false',
      spellData: 'all'
    }
  },
  {
    url: 'global.api.pvp.net/api/lol/static-data/euw/v1.2/summoner-spell',
    filename: 'get_all_summoner_spells_by_ids',
    params: {
      locale: 'fr_FR',
      dataById: 'true',
      spellData: 'all'
    }
  },
  {
    url: 'global.api.pvp.net/api/lol/static-data/euw/v1.2/summoner-spell/17',
    filename: 'get_summoner_spell_by_id',
    params: {
      locale: 'fr_FR',
      spellData: 'all'
    }
  },
  {
    url: 'global.api.pvp.net/api/lol/static-data/euw/v1.2/versions',
    filename: 'get_version',
    params: nil
  },
  # match-v2.2
  {
    # A faire
    url: 'euw.api.pvp.net/api/lol/euw/v2.2/match/1617870200',
    filename: 'get_match_by_id',
    params: nil
  },
  # matchlist-v2.2
  {
    url: 'euw.api.pvp.net/api/lol/euw/v2.2/matchlist/by-summoner/20639710',
    filename: 'match_list',
    params: nil
  },
  # stats-v1.3
  {
    url: 'euw.api.pvp.net/api/lol/euw/v1.3/stats/by-summoner/20639710/ranked',
    filename: 'get_player_stat_ranked',
    params: {
      season: 'SEASON2015'
    }
  },
  {
    url: 'euw.api.pvp.net/api/lol/euw/v1.3/stats/by-summoner/20639710/summary',
    filename: 'get_player_stat_summaries',
    params: {
      season: 'SEASON2015'
    }
  },
  # summoner-v1.4
  {
    url: 'euw.api.pvp.net/api/lol/euw/v1.4/summoner/by-name/pacoloco',
    filename: 'summoner',
    params: nil
  },
  {
    url: 'euw.api.pvp.net/api/lol/euw/v1.4/summoner/by-name/pacoloco',
    filename: 'get_summoner_by_name',
    params: nil
  },
  {
    url: 'euw.api.pvp.net/api/lol/euw/v1.4/summoner/20639710',
    filename: 'get_summoner_by_id',
    params: nil
  },
  {
    url: 'euw.api.pvp.net/api/lol/euw/v1.4/summoner/20639710/masteries',
    filename: 'get_summoner_masteries_by_id',
    params: nil
  },
  {
    url: 'euw.api.pvp.net/api/lol/euw/v1.4/summoner/20639710/runes',
    filename: 'get_summoner_runes_by_id',
    params: nil
  },
  # featured-games-v1.0
  {
    url: 'euw.api.pvp.net/observer-mode/rest/featured',
    filename: 'get_featured_games',
    params: nil
  }
  # current-game-v1.0
  # {
  #   :url => "euw.api.pvp.net/observer-mode/rest/consumer/getSpectatorGameInfo/EUW1/43921069",
  #   :filename => "get_current_game",
  #   :params => nil
  # }
]

class Mock
  attr_accessor :data, :url, :file

  def format_url
    full_url = "https://#{data[:url]}"
    full_url += "\?"
    unless data[:params].nil?
      data[:params].each do |key, val|
        full_url += "#{key}\=#{val}"
        full_url += "\&"
      end
    end
    full_url += "api_key\=#{API_KEY}"

    self.url = full_url
    self.file = data[:filename]
  end

  def call_curl
    Kernel.system "curl -is '#{url}' > spec/mock_response/#{file}.json"
  end
end

# List CURL commands
puts "Start curl script at [#{Time.now.strftime '%H:%M:%S'}]"

TAB_CALLS.each do |call|
  mock = Mock.new
  mock.data = call
  mock.format_url
  mock.call_curl
  puts "[#{Time.now.strftime '%H:%M:%S'}] -> #{mock.file}"
  sleep(2)
end

puts "Done at [#{Time.now.strftime '%H:%M:%S'}]"
