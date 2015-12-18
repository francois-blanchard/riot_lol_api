module RiotLolApi
  module Model
    class Stat
      # attr
      # :totalDamageDealtToChampions :goldEarned :item2 :item1 :wardPlaced :totalDamageTaken :item0 :physicalDamageDealtPlayer :totalUnitsHealed :level :magicDamageDealtToChampions :magicDamageDealtPlayer :assists :magicDamageTaken :numDeaths :totalTimeCrowdControlDealt :physicalDamageTaken :win :team :sightWardsBought :totalDamageDealt :totalHeal :item4 :item3 :item6 :minionsKilled :timePlayed :physicalDamageDealtToChampions :trueDamageTaken :goldSpent

      def initialize(options = {})
        options.each do |key, value|
          self.class.send(:attr_accessor, key.to_sym)
          instance_variable_set("@#{key}", value)
        end
      end
    end
  end
end
