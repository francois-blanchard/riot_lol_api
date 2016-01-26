module RiotLolApi
  module Model
    class Team
      include RiotLolApi::Concern::Init

      def win?
        winner
      end
    end
  end
end
