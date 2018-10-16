class TournamentProcessor
  attr_accessor :tournament

  def initialize(tournament)
    self.tournament = tournament
  end

  def play_division_games!
    Play.transaction do
      play_division_game!(TeamTournament::DIVISION_A)
      play_division_game!(TeamTournament::DIVISION_B)
    end
  end

  private

  def play_division_game!(division_name)
    teams_array(division_name).combination(2).each do |teams_pair|
      Play.create(
        tournament: tournament,
        round:      division_name,
        team_a:     teams_pair.first,
        team_b:     teams_pair.second,
        winner:     teams_pair.sample
      )
    end
  end

  def teams_array(division_name)
    tournament.teams.division(division_name).pluck(:id)
  end
end
