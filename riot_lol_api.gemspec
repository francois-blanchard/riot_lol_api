# coding: utf-8

# __________.__        __                                      _____ __________.___
# \______   \__| _____/  |_     _________    _____   ____     /  _  \\______   \   |
#  |       _/  |/  _ \   __\   / ___\__  \  /     \_/ __ \   /  /_\  \|     ___/   |
#  |    |   \  (  <_> )  |    / /_/  > __ \|  Y Y  \  ___/  /    |    \    |   |   |
#  |____|_  /__|\____/|__|    \___  (____  /__|_|  /\___  > \____|__  /____|   |___|
#         \/                 /_____/     \/      \/     \/          \/

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'riot_lol_api/version'

Gem::Specification.new do |spec|
  spec.name          = 'riot_lol_api'
  spec.version       = RiotLolApi::VERSION
  spec.authors       = ['francois_blanchard']
  spec.email         = ['francois.blanchard1@gmail.com']
  spec.summary       = 'Riot games api'
  spec.description   = 'Riot games api wrapper for ruby'
  spec.homepage      = 'https://github.com/francois-blanchard/riot_lol_api'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.11.2'
  spec.add_development_dependency 'rake', '~> 10.4.2'
  spec.add_development_dependency 'rspec', '~> 3.4.0'
  spec.add_development_dependency 'factory_girl', '~> 4.5.0'
  spec.add_development_dependency 'pry', '~> 0.10.1'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'codeclimate-test-reporter', '~> 0.4.8'
  spec.add_development_dependency 'vcr', '~> 3.0.1'
  spec.add_development_dependency 'webmock', '~> 1.22.5'

  spec.add_dependency 'httparty', '~> 0.13.7'
  spec.add_dependency 'activesupport', '~> 4.2.5'
end
