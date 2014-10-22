# Gem Riot games API wrapper for Ruby - League of Legends

[![Gem Version](https://badge.fury.io/rb/riot_lol_api.svg)](http://badge.fury.io/rb/riot_lol_api)

```
 __________.__        __                                      _____ __________.___
 \______   \__| _____/  |_     _________    _____   ____     /  _  \\______   \   |
  |       _/  |/  _ \   __\   / ___\__  \  /     \_/ __ \   /  /_\  \|     ___/   |
  |    |   \  (  <_> )  |    / /_/  > __ \|  Y Y  \  ___/  /    |    \    |   |   |
  |____|_  /__|\____/|__|    \___  (____  /__|_|  /\___  > \____|__  /____|   |___|
         \/                 /_____/     \/      \/     \/          \/
```

## Status

###V 0.1.0

```
- champion-v1.2 ... NO IMPLEMENT
- game-v1.3 ... OK
- league-v2.4 ... PROGRESS
  - /by-summoner/{summonerIds}/entry ... OK
- lol-static-data-v1.2 ... OK
- lol-status-v1.0 ... NO IMPLEMENT
- match-v2.2 ... PROGRESS
- stats-v1.3 ... OK
- summoner-v1.4 ... OK
  - /{summonerIds}/name ... NO IMPLEMENT
- team-v2.3 ... NO IMPLEMENT
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
# Set token
RiotLolApi::TOKEN = XXXXXXXXXXXXXXXXXXXXXXXXXXXX

# Create client
client = RiotLolApi::Client.new(:region => 'your_region')

# Start get data
summoner = client.get_summoner_by_name 'your_summoner_name'

```

Methods
```ruby
##########
# CLIENT #
##########

# Create client object
client = RiotLolApi::Client.new(:region => 'your_region')

############
# SUMMONER #
############

# Get summoner by name
# params : name => string
client.get_summoner_by_name 'pacoloco'

# Get summoner by id
# params : id => integer
client.get_summoner_by_id 20639710

# Get sumoner masteries
summoner.masteries

# Get sumoner runes
summoner.runes

# Get sumoner games
summoner.games

# Get sumoner stat_summaries
summoner.stat_summaries

# Get sumoner get_league_stats
summoner.get_league_stats

############
# CHAMPION #
############

# Get champion by id
# params :
# id => integer,
# data => hash (version, champData) - default => nil,
# locale => string ('fr_FR','en_EN', ...) - default => 'fr_FR'
client.get_champion_by_id id_champ, {:version => num_version, :champData => 'all'}, 'fr_FR'

# Get all champions
# params :
# data => hash (version, champData) - default => nil,
# sort_id => boolean - default => false
# locale => string ('fr_FR','en_EN', ...) - default => 'fr_FR'
client.get_all_champions {:version => num_version, :champData => 'all'}, 'false', 'fr_FR'

########
# ITEM #
########

# Get item by id
# params :
# id => integer,
# data => hash (version, itemListData) - default => nil,
# locale => string ('fr_FR','en_EN', ...) - default => 'fr_FR'
client.get_item_by_id id, {:version => num_version, :itemListData => 'all'}, 'fr_FR'

# Get all items
# params :
# data => hash (version, itemListData) - default => nil,
# locale => string ('fr_FR','en_EN', ...) - default => 'fr_FR'
client.get_all_items {:version => num_version, :itemListData => 'all'}, 'fr_FR'

###########
# MASTERY #
###########

# Get masteries by id
# params :
# id => integer,
# data => hash (version, masteryListData) - default => nil,
# locale => string ('fr_FR','en_EN', ...) - default => 'fr_FR'
client.get_mastery_by_id id, {:version => num_version, :masteryListData => 'all'}, 'fr_FR'

# Get all masteries
# params :
# data => hash (version, masteryListData) - default => nil,
# locale => string ('fr_FR','en_EN', ...) - default => 'fr_FR'
client.get_all_masteries {:version => num_version, :masteryListData => 'all'}, 'fr_FR'

########
# RUNE #
########

# Get rune by id
# params :
# id => integer,
# data => hash (version, runeListData) - default => nil,
# locale => string ('fr_FR','en_EN', ...) - default => 'fr_FR'
client.get_rune_by_id id, {:version => num_version, :runeListData => 'all'}, 'fr_FR'

# Get all rune
# params :
# data => hash (version, runeListData) - default => nil,
# locale => string ('fr_FR','en_EN', ...) - default => 'fr_FR'
client.get_all_runes {:version => num_version, :runeListData => 'all'}, 'fr_FR'

##################
# SUMMONER SPELL #
##################

# Get summoner spell by id
# params :
# id => integer,
# data => hash (version, spellData) - default => nil,
# locale => string ('fr_FR','en_EN', ...) - default => 'fr_FR'
client.get_summoner_spell_by_id id, {:version => num_version, :spellData => 'all'}, 'fr_FR'

# Get all summoner spell
# params :
# data => hash (version, spellData) - default => nil,
# sort_id => boolean - default => false
# locale => string ('fr_FR','en_EN', ...) - default => 'fr_FR'
client.get_all_summoner_spells {:version => num_version, :spellData => 'all'}, 'false', 'fr_FR'

###############
# INFORMATION #
###############

# Get version
client.get_versions

```

## Change logs

- v 0.1.12 : Add class datnum for champion entry
- v 0.1.11 : Fix class mini_sery for league entry
- v 0.1.1 : Add class mini_sery for league entry
- v 0.1.0 : First stable version

## Contributing

1. Fork it ( http://github.com/<my-github-username>/riot_lol_api/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
