require 'riot_lol_api/model/stat'
require 'riot_lol_api/model/recommended'
require 'riot_lol_api/model/image'
require 'riot_lol_api/model/spell'
require 'riot_lol_api/model/info'
require 'riot_lol_api/model/passive'
require 'riot_lol_api/model/skin'
require 'riot_lol_api/model/datum'

module RiotLolApi
  module Model
    class Champion

      def initialize(options = {})
        options.each do |key, value|
          self.class.send(:attr_accessor, key.to_sym)
          instance_variable_set("@#{key}", value)
        end
      end

    end
  end
end