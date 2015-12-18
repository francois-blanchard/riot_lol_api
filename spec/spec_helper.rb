require 'bundler/setup'
require 'riot_lol_api' # and any other gems you need
require 'webmock/rspec'
require 'factory_girl'
require "codeclimate-test-reporter"

RiotLolApi::TOKEN = "KEY"

Bundler.setup
FactoryGirl.find_definitions

CodeClimate::TestReporter.start

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'
end
