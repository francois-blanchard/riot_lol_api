API_KEY = ARGV[0]

tab_calls = [
  {
    :url => "euw.api.pvp.net/api/lol/euw/v2.4/league/by-summoner/20639710/entry",
    :filename => "get_player_league",
    :params => ""
  },
  {
    :url => "global.api.pvp.net/api/lol/static-data/euw/v1.2/champion",
    :filename => "get_all_champions_by_ids_all_data",
    :params => "locale\=fr_FR\&champData\=all\&"
  }
]

puts "Start curl script at [#{Time.now.strftime '%H:%M:%S'}]"

tab_calls.each do |call|
  url = "https://#{call[:url]}\?#{call[:params]}api_key\=#{API_KEY}"
  Kernel.system "curl -is '#{url}' > spec/mock_response/#{call[:filename]}.json"
  puts "#{call[:filename]} has been updated."
end

puts "Done at [#{Time.now.strftime '%H:%M:%S'}]"
