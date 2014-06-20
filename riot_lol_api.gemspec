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
  spec.name          = "riot_lol_api"
  spec.version       = RiotLolApi::VERSION
  spec.authors       = ["francois_blanchard"]
  spec.email         = ["francois.blanchard1@gmail.com"]
  spec.summary       = %q{Riot games api}
  spec.description   = %q{Riot games api wrapper for ruby}
  spec.homepage      = "https://github.com/francois-blanchard/riot_lol_api"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.14.1"
  spec.add_development_dependency "factory_girl"
  spec.add_development_dependency "webmock"
  
  spec.add_dependency "httparty"
end