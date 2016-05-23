# Gem Riot games API wrapper for Ruby - League of Legends

[![Build Status](https://travis-ci.org/francois-blanchard/riot_lol_api.svg)](https://travis-ci.org/francois-blanchard/riot_lol_api)
[![Code Climate](https://codeclimate.com/github/francois-blanchard/riot_lol_api/badges/gpa.svg)](https://codeclimate.com/github/francois-blanchard/riot_lol_api)
[![Issue Count](https://codeclimate.com/github/francois-blanchard/riot_lol_api/badges/issue_count.svg)](https://codeclimate.com/github/francois-blanchard/riot_lol_api)
[![Test Coverage](https://codeclimate.com/github/francois-blanchard/riot_lol_api/badges/coverage.svg)](https://codeclimate.com/github/francois-blanchard/riot_lol_api/coverage)

```
 __________.__        __                                      _____ __________.___
 \______   \__| _____/  |_     _________    _____   ____     /  _  \\______   \   |
  |       _/  |/  _ \   __\   / ___\__  \  /     \_/ __ \   /  /_\  \|     ___/   |
  |    |   \  (  <_> )  |    / /_/  > __ \|  Y Y  \  ___/  /    |    \    |   |   |
  |____|_  /__|\____/|__|    \___  (____  /__|_|  /\___  > \____|__  /____|   |___|
         \/                 /_____/     \/      \/     \/          \/
```

## Status

### [![Gem Version](https://badge.fury.io/rb/riot_lol_api.svg)](http://badge.fury.io/rb/riot_lol_api)

```
- champion-v1.2         NO IMPLEMENT
- championmastery       PROGRESS
- current-game-v1.0     OK
- featured-games-v1.0   OK
- game-v1.3             OK
- league-v2.5           PROGRESS
- lol-static-data-v1.2  OK
- lol-status-v1.0       NO IMPLEMENT
- match-v2.2            OK
- matchlist-v2.2        PROGRESS
- stats-v1.3            OK
- summoner-v1.4         OK
- team-v2.4             NO IMPLEMENT
```

## Installation

Add this line to your application's Gemfile:
```ruby
gem 'riot_lol_api'
```

And then execute:
```shell
bundle
```

Or install it yourself as:
```shell
gem install riot_lol_api
```

## Usage
###1) Token
Get token api on [http://developer.riotgames.com/](http://developer.riotgames.com/)

###2) Scripts
Sample scripts
```ruby
# Create client
client = RiotLolApi::Client.new do |config|
  config.region = 'your_region'
  config.api_key = 'xxxxxxxxxxxx'
end

# Start get data
summoner = client.get_summoner_by_name 'your_summoner_name'

##########
# CLIENT #
##########

client.get_summoner_by_name 'pacoloco'
client.get_summoner_by_id 20639710
client.featured_games
client.current_game(summoner_id)
client.versions

############
# SUMMONER #
############

summoner.masteries
summoner.runes
summoner.games
summoner.stat_summaries
summoner.get_league_stats
summoner.get_match_history
summoner.current_game

```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/riot_lol_api/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
