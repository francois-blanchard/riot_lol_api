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

Under development.

champion-v1.2 ... NO IMPLEMENT
game-v1.3 ... OK
league-v2.4 ... NO IMPLEMENT


## Installation

Add this line to your application's Gemfile:
```ruby
gem 'riot_lol_api'
```

And then execute:
```shell
$ bundle
```

Or install it yourself as:
```shell
$ gem install riot_lol_api
```

## Usage

Get token api on [http://developer.riotgames.com/](http://developer.riotgames.com/)

Script exemple 
```ruby
# Set token
RiotLolApi::TOKEN = XXXXXXXXXXXXXXXXXXXXXXXXXXXX

# Create client
client = RiotLolApi::Client.new(:region => 'your_region')

# Start get data
summoner = client.get_summoner_by_name 'pacoloco'

# => #<RiotLolApi::Model::Summoner:0x007fc5a06f8048 @id=20639710, @name="PacoLoco", @profile_icon_id=8, @summoner_level=30, @revision_date=1398345588000, @region="euw">

```

Class & Methods
```ruby
##################
# Class : Client #
##################

# Get client object
client = RiotLolApi::Client.new(:region => 'your_region')

# Get summoner by name
# params : name => string
client.get_summoner_by_name 'pacoloco'
# => #<RiotLolApi::Model::Summoner:0x007fc5a06f8048 @id=20639710, @name="PacoLoco", @profile_icon_id=8, @summoner_level=30, @revision_date=1398345588000, @region="euw">

```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/riot_lol_api/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
