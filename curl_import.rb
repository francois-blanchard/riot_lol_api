# Params
API_KEY = ARGV[0]

# Tab files
TAB_CALLS = [
  # lol-static-data-v1.2
  {
    :url => "global.api.pvp.net/api/lol/static-data/euw/v1.2/champion",
    :filename => "get_all_champions_by_ids",
    :params => {
        :locale => 'fr_FR'
      }
  },
  {
    :url => "global.api.pvp.net/api/lol/static-data/euw/v1.2/champion",
    :filename => "get_all_champions_by_ids_all_data",
    :params => {
        :locale => 'fr_FR',
        :champData => 'all'
      }
  },
  {
    :url => "global.api.pvp.net/api/lol/static-data/euw/v1.2/item",
    :filename => "get_all_item",
    :params => {
        :locale => 'fr_FR',
        :itemListData => 'all'
      }
  },
  {
    :url => "global.api.pvp.net/api/lol/static-data/euw/v1.2/mastery",
    :filename => "get_all_masteries",
    :params => {
      :locale => 'fr_FR',
      :masteryListData => 'all'
    }
  },
  {
    :url => "global.api.pvp.net/api/lol/static-data/euw/v1.2/rune",
    :filename => "get_all_runes",
    :params => {
      :locale => 'fr_FR',
      :runeListData => 'all'
    }
  },
  {
    :url => "global.api.pvp.net/api/lol/static-data/euw/v1.2/summoner-spell",
    :filename => "get_all_summoner_spells",
    :params => {
      :locale => 'fr_FR',
      :dataById => 'false',
      :spellData => 'all'
    }
  },
  {
    :url => "global.api.pvp.net/api/lol/static-data/euw/v1.2/summoner-spell",
    :filename => "get_all_summoner_spells_by_ids",
    :params => {
      :locale => 'fr_FR',
      :dataById => 'true',
      :spellData => 'all'
    }
  },
  {
    :url => "global.api.pvp.net/api/lol/static-data/euw/v1.2/champion/412",
    :filename => "get_champion_by_id",
    :params => {
      :locale => 'fr_FR'
    }
  },
  {
    :url => "global.api.pvp.net/api/lol/static-data/euw/v1.2/champion/412",
    :filename => "get_champion_by_id_all_data",
    :params => {
      :locale => 'fr_FR',
      :champData => 'all'
    }
  },
  # league-v2.5
  {
    :url => "euw.api.pvp.net/api/lol/euw/v2.4/league/by-summoner/20639710/entry",
    :filename => "get_player_league",
    :params => nil
  },
  # match-v2.2
  {
    # A faire
    :url => "euw.api.pvp.net/api/lol/euw/v2.2/match/1617870200",
    :filename => "get_match_by_id",
    :params => nil
  },
  # matchhistory-v2.2
  {
    # A faire
    :url => "euw.api.pvp.net/api/lol/euw/v2.2/matchhistory/20639710",
    :filename => "get_match_history",
    :params => nil
  }
]

class Mock
  attr_accessor :data, :url, :file

  def format_url
    full_url = "https://#{self.data[:url]}"
    full_url += "\?"
    unless self.data[:params].nil?
      self.data[:params].each do |key,val|
        full_url+= "#{key}\=#{val}"
        full_url+= "\&"
      end
    end
    full_url += "api_key\=#{API_KEY}"

    self.url = full_url
    self.file = self.data[:filename]
  end

  def call_curl
    Kernel.system "curl -is '#{self.url}' > spec/mock_response/#{self.file}.json"
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
