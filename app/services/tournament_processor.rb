class TournamentProcessor
  attr_accessor :tournament

  MAX_NUM_OF_WINNERS_IN_DIVISION = 4.freeze
  NUMBER_OF_ROUNDS_IN_PLAYOFF    = 3.freeze

  def initialize(tournament)
    self.tournament = tournament
  end

  def play_division_games!
    Play.transaction do
      play_division_game!(TeamTournament::DIVISION_A)
      play_division_game!(TeamTournament::DIVISION_B)
    end

    mark_division_winners!
  end

  def playoff!
    Play.transaction do
      schedule = initial_playoff_schedule

      NUMBER_OF_ROUNDS_IN_PLAYOFF.times do |round|
        winners = schedule.map do |teams|
          Play.create(
            tournament: tournament,
            round:      Play::ROUND_NAMES[round],
            team_a_id:  teams.first,
            team_b_id:  teams.second,
            winner:     teams.sample
          ).winner
        end

        schedule = winners.in_groups_of(2)
      end
    end
  end

  private

  def play_division_game!(division_name)
    teams_array(division_name).combination(2).each do |teams_pair|
      Play.create(
        tournament: tournament,
        round:      division_name,
        team_a_id:  teams_pair.first,
        team_b_id:  teams_pair.second,
        winner:     teams_pair.sample
      )
    end
  end

  def initial_playoff_schedule
    division_a_winners = tournament.teams.division_winners(TeamTournament::DIVISION_A).pluck(:id)
    division_b_winners = tournament.teams.division_winners(TeamTournament::DIVISION_B).pluck(:id)

    division_a_winners.zip(division_b_winners.reverse)
  end

  def teams_array(division_name)
    tournament.teams.division(division_name).pluck(:id)
  end

  def mark_division_winners!
    TeamTournament.where(team_id: both_division_winners, tournament: tournament).update(division_winner: true)
  end

  def both_division_winners
    division_winners(TeamTournament::DIVISION_A) + division_winners(TeamTournament::DIVISION_B)
  end

  def division_winners(division_name)
    all_division_winners(division_name)
      .inject(Hash.new(0)) { |h,v| h[v] += 1; h }
      .sort_by {|k,v| -v }
      .map(&:first)
      .first(MAX_NUM_OF_WINNERS_IN_DIVISION)
  end

  def all_division_winners(division_name)
    Play.where(tournament: tournament, round: division_name).pluck(:winner)
  end
end
