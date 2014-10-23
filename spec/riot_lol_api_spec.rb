require 'spec_helper'
require 'riot_lol_api'
require 'pp'

describe RiotLolApi::Client do

  before(:each) do

    realm_response = File.read 'spec/mock_response/get_realm.json'
    stub_request(:get, "https://global.api.pvp.net/api/lol/static-data/euw/v1.2/realm?api_key=#{RiotLolApi::TOKEN}").to_return(realm_response)

  end

  describe "can use string and hash ovewriting method" do

    it "transform string CamelCase in to symbol" do
      test = "lolApiTest"
      expect(test.to_symbol).to eq :lol_api_test
    end

    it "transform hash keys CamelCase in to symbol" do
      hash_test = {"lolApiTest" => "lol", "testLol" => "truc"}
      expect(hash_test.to_symbol).to eq({:lol_api_test => "lol", :test_lol => "truc"})
    end

    it "Add instance of class to_symbol" do
      hash_result = {"lolApiTest" => "lol", "testLol" => "truc", "masteries" => [{"id" => 4212,"rank" => 2},{"id" => 4233,"rank" => 3}], "stats" => {"truc" => 0, "machin" => 2}}.to_symbol
      # Test Array
      expect(hash_result[:masteries][0]).to be_a RiotLolApi::Model::Mastery
      # Test Hash
      expect(hash_result[:stats]).to be_a RiotLolApi::Model::Stat
    end

  end

  describe "set realm when create client" do
    it "define RiotLolApi::REALM" do
      client = FactoryGirl.build(:client)
      expect(RiotLolApi::Client.realm).to eq({"css" => "0.152.55", "dd" => "4.17.1","l" => "en_US", "n" => {"item" => "4.18.1","rune" => "4.17.1", "mastery" => "4.17.1", "summoner" => "4.18.1", "champion" => "4.18.1", "profileicon" => "4.18.1", "language" => "4.17.1"}, "profileiconmax" => 28, "v" => "4.18.1", "lg" => "0.152.55", "cdn" => "http://ddragon.leagueoflegends.com/cdn"})
    end
  end

  describe "get_summoner_by_name" do

    before(:each) do
      # Create client
      client = FactoryGirl.build(:client)
      name = "pacoloco"

      api_response = File.read 'spec/mock_response/get_summoner_by_name.json'
      stub_request(:get, "https://#{client.region}.api.pvp.net/api/lol/euw/v1.4/summoner/by-name/#{name}?api_key=#{RiotLolApi::TOKEN}").to_return(api_response)

      @summoner_test = client.get_summoner_by_name(name)
    end

    it "should get summoner object" do
      expect(@summoner_test).to be_a RiotLolApi::Model::Summoner
    end

    it "should have good attributes" do
      summoner = FactoryGirl.build(:summoner)

      expect(@summoner_test.id).to eq(summoner.id)
      expect(@summoner_test.name).to eq(summoner.name)
      expect(@summoner_test.profile_icon_id).to eq(summoner.profile_icon_id)
      expect(@summoner_test.summoner_level).to eq(summoner.summoner_level)
      expect(@summoner_test.revision_date).to eq(summoner.revision_date)
      expect(@summoner_test.region).to eq(summoner.region)
    end
  end

  describe "get_summoner_by_id" do

    before(:each) do
      # Create client
      client = FactoryGirl.build(:client)
      id = 20639710

      api_response = File.read 'spec/mock_response/get_summoner_by_id.json'
      stub_request(:get, "https://#{client.region}.api.pvp.net/api/lol/euw/v1.4/summoner/#{id}?api_key=#{RiotLolApi::TOKEN}").to_return(api_response)

      @summoner_test = client.get_summoner_by_id(id)
    end

    it "should get summoner object" do
      expect(@summoner_test).to be_a RiotLolApi::Model::Summoner
    end

    it "should have good attributes" do
      summoner = FactoryGirl.build(:summoner)

      expect(@summoner_test.id).to eq(summoner.id)
      expect(@summoner_test.name).to eq(summoner.name)
      expect(@summoner_test.profile_icon_id).to eq(summoner.profile_icon_id)
      expect(@summoner_test.summoner_level).to eq(summoner.summoner_level)
      expect(@summoner_test.revision_date).to eq(summoner.revision_date)
      expect(@summoner_test.region).to eq(summoner.region)
    end
  end

  describe "get summoner masteries pages" do

    before(:each) do
      # Create summoner
      summoner = FactoryGirl.build(:summoner)

      api_response = File.read 'spec/mock_response/get_summoner_masteries_by_id.json'
      stub_request(:get, "https://#{summoner.region}.api.pvp.net/api/lol/euw/v1.4/summoner/#{summoner.id}/masteries?api_key=#{RiotLolApi::TOKEN}").to_return(api_response)

      @page_test = summoner.masteries
    end

    it "should have good attributes" do
      @page_test.each do |page|
        expect(page).to be_a RiotLolApi::Model::Page
        page.masteries.each do |mastery|
          expect(mastery).to be_a RiotLolApi::Model::Mastery
        end
      end
    end
  end

  describe "get summoner runes" do

    before(:each) do
      # Create summoner
      summoner = FactoryGirl.build(:summoner)

      api_response = File.read 'spec/mock_response/get_summoner_runes_by_id.json'
      stub_request(:get, "https://#{summoner.region}.api.pvp.net/api/lol/euw/v1.4/summoner/#{summoner.id}/runes?api_key=#{RiotLolApi::TOKEN}").to_return(api_response)

      @rune_test = summoner.runes
    end

    it "should have good attributes" do
      @rune_test.each do |rune|
        expect(rune).to be_a RiotLolApi::Model::Page
        rune.slots[0..1].each do |slot|
          expect(slot).to be_a RiotLolApi::Model::Slot
        end
      end
    end
  end

  describe "get summoner games" do

    before(:each) do
      # Create summoner
      summoner = FactoryGirl.build(:summoner)

      api_response = File.read 'spec/mock_response/get_summoner_games_by_id.json'
      stub_request(:get, "https://#{summoner.region}.api.pvp.net/api/lol/euw/v1.3/game/by-summoner/#{summoner.id}/recent?api_key=#{RiotLolApi::TOKEN}").to_return(api_response)

      @game_tests = summoner.games
    end

    it "should have good attributes" do
      game = FactoryGirl.build(:game)

      game_test = @game_tests.first
      expect(game_test.game_id).to eq(game.game_id)
      expect(game_test.invalid).to eq(game.invalid)
      expect(game_test.game_mode).to eq(game.game_mode)
      expect(game_test.game_type).to eq(game.game_type)
      expect(game_test.sub_type).to eq(game.sub_type)
      expect(game_test.map_id).to eq(game.map_id)
      expect(game_test.team_id).to eq(game.team_id)
      expect(game_test.champion_id).to eq(game.champion_id)
      expect(game_test.spell1).to eq(game.spell1)
      expect(game_test.spell2).to eq(game.spell2)
      expect(game_test.level).to eq(game.level)
      expect(game_test.ip_earned).to eq(game.ip_earned)
      expect(game_test.create_date).to eq(game.create_date)

      expect(game_test.fellow_players.first).to be_a RiotLolApi::Model::FellowPlayer

      expect(game_test.stats).to be_a RiotLolApi::Model::Stat
    end

  end

  describe "get_champion_by_id" do

    before(:each) do
      # Create client
      client = FactoryGirl.build(:client)
      id_champion = 412

      api_response = File.read 'spec/mock_response/get_champion_by_id.json'
      stub_request(:get, "https://global.api.pvp.net/api/lol/static-data/euw/v1.2/champion/#{id_champion}?locale=fr_FR&api_key=#{RiotLolApi::TOKEN}").to_return(api_response)

      @champion_test = client.get_champion_by_id(id_champion)
    end

    it "should get summoner object" do
      expect(@champion_test).to be_a RiotLolApi::Model::Champion
    end

    it "should have good attributes" do
      champion = FactoryGirl.build(:champion)

      expect(@champion_test.id).to eq(champion.id)
      expect(@champion_test.key).to eq(champion.key)
      expect(@champion_test.name).to eq(champion.name)
      expect(@champion_test.title).to eq(champion.title)
    end
  end

  describe "get_champion_by_id_all_data" do

    before(:each) do
      # Create client
      client = FactoryGirl.build(:client)
      id_champion = 412

      api_response = File.read 'spec/mock_response/get_champion_by_id_all_data.json'
      stub_request(:get, "https://global.api.pvp.net/api/lol/static-data/euw/v1.2/champion/#{id_champion}?locale=fr_FR&champData=all&api_key=#{RiotLolApi::TOKEN}").to_return(api_response)

      @champion_test = client.get_champion_by_id(id_champion,{:champData => 'all'})
    end

    it "should get summoner object" do
      expect(@champion_test).to be_a RiotLolApi::Model::Champion
    end

    it "should have good attributes" do
      champion = FactoryGirl.build(:champion)

      expect(@champion_test.id).to eq(champion.id)
      expect(@champion_test.key).to eq(champion.key)
      expect(@champion_test.name).to eq(champion.name)
      expect(@champion_test.title).to eq(champion.title)
    end

    # Image Champion

    it "should a valid full url image champion" do
      expect(@champion_test.image.full_url).to eq("http://ddragon.leagueoflegends.com/cdn/#{RiotLolApi::Client.realm['v']}/img/champion/Thresh.png")
    end

    it "should a valid sprite url image champion" do
      expect(@champion_test.image.sprite_url).to eq("http://ddragon.leagueoflegends.com/cdn/#{RiotLolApi::Client.realm['v']}/img/sprite/champion3.png")
    end

    it "should a valid full url image passive" do
      expect(@champion_test.passive.image.full_url).to eq("http://ddragon.leagueoflegends.com/cdn/#{RiotLolApi::Client.realm['v']}/img/passive/Thresh_Passive.png")
    end
  end

  describe "get_all_champions_by_ids" do

    before(:each) do
      # Create client
      client = FactoryGirl.build(:client)

      api_response = File.read 'spec/mock_response/get_all_champions_by_ids.json'
      stub_request(:get, "https://global.api.pvp.net/api/lol/static-data/euw/v1.2/champion?locale=fr_FR&dataById=true&api_key=#{RiotLolApi::TOKEN}").to_return(api_response)

      @all_champion_test = client.get_all_champions(nil,true)
    end

    it "should have good attributes" do
      @all_champion_test.each do |champion|
        expect(champion).to be_a RiotLolApi::Model::Champion
      end
    end
  end

  describe "get_all_champions_by_ids_all_data" do

    before(:each) do
      # Create client
      client = FactoryGirl.build(:client)

      api_response = File.read 'spec/mock_response/get_all_champions_by_ids_all_data.json'
      stub_request(:get, "https://global.api.pvp.net/api/lol/static-data/euw/v1.2/champion?locale=fr_FR&dataById=false&champData=all&api_key=#{RiotLolApi::TOKEN}").to_return(api_response)

      @all_champion_test = client.get_all_champions({:champData => 'all'})
    end

    it "should have good attributes" do
      @all_champion_test.each do |champion|
        expect(champion).to be_a RiotLolApi::Model::Champion
        expect(champion.stats).to be_a RiotLolApi::Model::Stat
      end
    end
  end

  describe "get_stat_summaries" do

    before(:each) do
      # Create client
      summoner = FactoryGirl.build(:summoner)

      api_response = File.read 'spec/mock_response/get_player_stat_summaries.json'
      stub_request(:get, "https://#{summoner.region}.api.pvp.net/api/lol/euw/v1.3/stats/by-summoner/20639710/summary?season=SEASON4&api_key=#{RiotLolApi::TOKEN}").to_return(api_response)

      @stat_summaries_test = summoner.stat_summaries("SEASON4")
    end

    it "should have good attributes" do
      @stat_summaries_test.each do |stat_summary|
        expect(stat_summary).to be_a RiotLolApi::Model::PlayerStatSummary
        expect(stat_summary.aggregated_stats).to be_a RiotLolApi::Model::AggregatedStat
      end
    end
  end

  describe "get_stat_ranks" do

    before(:each) do
      # Create client
      summoner = FactoryGirl.build(:summoner)

      api_response = File.read 'spec/mock_response/get_player_stat_ranked.json'
      stub_request(:get, "https://#{summoner.region}.api.pvp.net/api/lol/euw/v1.3/stats/by-summoner/20639710/ranked?season=SEASON4&api_key=#{RiotLolApi::TOKEN}").to_return(api_response)

      @stat_ranks_test = summoner.stat_ranks("SEASON4")
    end

    it "should have good attributes" do
      @stat_ranks_test.each do |stat_rank|
        expect(stat_rank).to be_a RiotLolApi::Model::PlayerStatRank
        expect(stat_rank.stats).to be_a RiotLolApi::Model::Stat
      end
    end
  end

  describe "get_all_items" do
    before(:each) do
      # Create client
      client = FactoryGirl.build(:client)

      api_response = File.read 'spec/mock_response/get_all_item.json'
      stub_request(:get, "https://global.api.pvp.net/api/lol/static-data/euw/v1.2/item?locale=fr_FR&itemListData=all&api_key=#{RiotLolApi::TOKEN}").to_return(api_response)

      @all_item_test = client.get_all_items({:itemListData => 'all'})
    end

    it "should have good attributes" do
      @all_item_test.each do |item|
        expect(item).to be_a RiotLolApi::Model::Item
        expect(item.image).to be_a RiotLolApi::Model::Image
      end
    end
  end

  describe "get_item_by_id" do
    before(:each) do
      # Create client
      client = FactoryGirl.build(:client)

      api_response = File.read 'spec/mock_response/get_item_by_id.json'
      stub_request(:get, "https://global.api.pvp.net/api/lol/static-data/euw/v1.2/item/2009?locale=fr_FR&itemListData=all&api_key=#{RiotLolApi::TOKEN}").to_return(api_response)

      @item_test = client.get_item_by_id(2009,{:itemListData => 'all'})
    end

    it "should have good attributes" do
      expect(@item_test).to be_a RiotLolApi::Model::Item
      expect(@item_test.image).to be_a RiotLolApi::Model::Image
      expect(@item_test.gold).to be_a RiotLolApi::Model::Gold
    end
  end

  describe "get_all_masteries" do
    before(:each) do
      # Create client
      client = FactoryGirl.build(:client)

      api_response = File.read 'spec/mock_response/get_all_masteries.json'
      stub_request(:get, "https://global.api.pvp.net/api/lol/static-data/euw/v1.2/mastery?locale=fr_FR&masteryListData=all&api_key=#{RiotLolApi::TOKEN}").to_return(api_response)

      @all_mastery_test = client.get_all_masteries({:masteryListData => 'all'})
    end

    it "should have good attributes" do
      @all_mastery_test.each do |mastery|
        expect(mastery).to be_a RiotLolApi::Model::Mastery
        expect(mastery.image).to be_a RiotLolApi::Model::Image
      end
    end
  end

  describe "get_mastery_by_id" do
    before(:each) do
      # Create client
      client = FactoryGirl.build(:client)

      api_response = File.read 'spec/mock_response/get_mastery_by_id.json'
      stub_request(:get, "https://global.api.pvp.net/api/lol/static-data/euw/v1.2/mastery/4353?locale=fr_FR&masteryData=all&api_key=#{RiotLolApi::TOKEN}").to_return(api_response)

      @mastery_test = client.get_mastery_by_id(4353,{:masteryData => 'all'})
    end

    it "should have good attributes" do
      expect(@mastery_test).to be_a RiotLolApi::Model::Mastery
      expect(@mastery_test.image).to be_a RiotLolApi::Model::Image
    end
  end

  describe "get_all_runes" do
    before(:each) do
      # Create client
      client = FactoryGirl.build(:client)

      api_response = File.read 'spec/mock_response/get_all_runes.json'
      stub_request(:get, "https://global.api.pvp.net/api/lol/static-data/euw/v1.2/rune?locale=fr_FR&runeListData=all&api_key=#{RiotLolApi::TOKEN}").to_return(api_response)

      @all_rune_test = client.get_all_runes({:runeListData => 'all'})
    end

    it "should have good attributes" do
      @all_rune_test.each do |rune|
        expect(rune).to be_a RiotLolApi::Model::Rune
        expect(rune.image).to be_a RiotLolApi::Model::Image
      end
    end
  end

  describe "get_rune_by_id" do
    before(:each) do
      # Create client
      client = FactoryGirl.build(:client)

      api_response = File.read 'spec/mock_response/get_rune_by_id.json'
      stub_request(:get, "https://global.api.pvp.net/api/lol/static-data/euw/v1.2/rune/5235?locale=fr_FR&runeData=all&api_key=#{RiotLolApi::TOKEN}").to_return(api_response)

      @rune_test = client.get_rune_by_id(5235,{:runeData => 'all'})
    end

    it "should have good attributes" do
      expect(@rune_test).to be_a RiotLolApi::Model::Rune
      expect(@rune_test.image).to be_a RiotLolApi::Model::Image
    end
  end

  describe "get_all_summoner_spells" do

    before(:each) do
      # Create client
      client = FactoryGirl.build(:client)

      api_response = File.read 'spec/mock_response/get_all_summoner_spells.json'
      stub_request(:get, "https://global.api.pvp.net/api/lol/static-data/euw/v1.2/summoner-spell?locale=fr_FR&dataById=false&spellData=all&api_key=#{RiotLolApi::TOKEN}").to_return(api_response)

      @all_summoner_spells = client.get_all_summoner_spells({:spellData => 'all'})
    end

    it "should have good attributes" do
      @all_summoner_spells.each do |summoner_spell|
        expect(summoner_spell).to be_a RiotLolApi::Model::Spell
        expect(summoner_spell.image).to be_a RiotLolApi::Model::Image
      end
    end
  end

  describe "get_all_summoner_spells_by_ids" do

    before(:each) do
      # Create client
      client = FactoryGirl.build(:client)

      api_response = File.read 'spec/mock_response/get_all_summoner_spells_by_ids.json'
      stub_request(:get, "https://global.api.pvp.net/api/lol/static-data/euw/v1.2/summoner-spell?locale=fr_FR&dataById=true&spellData=all&api_key=#{RiotLolApi::TOKEN}").to_return(api_response)

      @all_summoner_spells = client.get_all_summoner_spells({:spellData => 'all'},true)
    end

    it "should have good attributes" do
      @all_summoner_spells.each do |summoner_spell|
        expect(summoner_spell).to be_a RiotLolApi::Model::Spell
        expect(summoner_spell.image).to be_a RiotLolApi::Model::Image
      end
    end
  end

  describe "get_summoner_spell_by_id" do
    before(:each) do
      # Create client
      client = FactoryGirl.build(:client)

      api_response = File.read 'spec/mock_response/get_summoner_spell_by_id.json'
      stub_request(:get, "https://global.api.pvp.net/api/lol/static-data/euw/v1.2/summoner-spell/17?locale=fr_FR&spellData=all&api_key=#{RiotLolApi::TOKEN}").to_return(api_response)

      @summoner_spell_test = client.get_summoner_spell_by_id(17,{:spellData => 'all'})
    end

    it "should have good attributes" do
      expect(@summoner_spell_test).to be_a RiotLolApi::Model::Spell
      expect(@summoner_spell_test.image).to be_a RiotLolApi::Model::Image
    end
  end

  describe "get_versions" do
    before(:each) do
      # Create client
      client = FactoryGirl.build(:client)

      api_response = File.read 'spec/mock_response/get_version.json'
      stub_request(:get, "https://global.api.pvp.net/api/lol/static-data/euw/v1.2/versions?api_key=#{RiotLolApi::TOKEN}").to_return(api_response)

      @version_test = client.get_versions
    end

    it "should have good attributes" do
      expect(@version_test).to be_a Array
    end
  end

  describe "get_league_stats" do
    before(:each) do
      # Create client
      summoner = FactoryGirl.build(:summoner)

      api_response = File.read 'spec/mock_response/get_player_league.json'
      stub_request(:get, "https://euw.api.pvp.net/api/lol/euw/v2.4/league/by-summoner/20639710/entry?api_key=#{RiotLolApi::TOKEN}").to_return(api_response)

      @get_league = summoner.get_league_stats
    end

    it "should have good attributes" do
      expect(@get_league).to be_a Array
      expect(@get_league.first.entries.first).to be_a RiotLolApi::Model::Entry
      if @get_league.first.entries.first.respond_to?(:mini_series)
        expect(@get_league.first.entries.first.mini_series).to be_a RiotLolApi::Model::MiniSeries
      end
    end
  end

end
