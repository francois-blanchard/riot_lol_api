require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require 'bundler/setup'
require 'riot_lol_api' # and any other gems you need
require 'webmock/rspec'
require 'factory_girl'

RiotLolApi::FAKETOKEN = 'KEY'

Bundler.setup
FactoryGirl.find_definitions

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'
  config.after(:suite) do
    WebMock.disable_net_connect!(allow: 'codeclimate.com')
  end
end
