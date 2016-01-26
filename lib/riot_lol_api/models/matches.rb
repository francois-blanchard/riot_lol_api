module RiotLolApi
  module Model
    class Match
      include RiotLolApi::Concern::Init

      def which_team_win
        teams.first.win? ? teams.first.team_id : teams.last.team_id
      end
    end
  end
end
