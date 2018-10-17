class TournamentsController < ApplicationController
  def index
    @tournaments = Tournament.all
  end

  def create
    tournament = Tournament.create(
      name: Faker::Name.name + ' Tournament'
    )

    Tournament.transaction do
      teams = Tournament::MAX_ALLOWED_TEAMS_IN_DIVISION_COUNT.times do
        TeamTournament.create(team: Team.new(name: Faker::Team.name), tournament: tournament, division: TeamTournament::DIVISION_A)
      end

      teams = Tournament::MAX_ALLOWED_TEAMS_IN_DIVISION_COUNT.times do
        TeamTournament.create(team: Team.new(name: Faker::Team.name), tournament: tournament, division: TeamTournament::DIVISION_B)
      end
    end

    redirect_to tournaments_path
  end

  def show
    @tournament = Tournament.find(params[:id])

    @division_a_teams   = @tournament.teams.division(TeamTournament::DIVISION_A).order('division_winner DESC')
    @division_b_teams   = @tournament.teams.division(TeamTournament::DIVISION_B).order('division_winner DESC')
    @division_a_winners = @tournament.teams.division_winners(TeamTournament::DIVISION_A)
    @division_b_winners = @tournament.teams.division_winners(TeamTournament::DIVISION_B)

    @playoff_first_round  = Play.where(tournament: @tournament).playoff_first_round
    @playoff_second_round = Play.where(tournament: @tournament).playoff_second_round
    @playoff_final_round  = Play.where(tournament: @tournament).playoff_final_round
  end

  def generate_division_results
    @tournament = Tournament.find(params[:tournament_id])

    processor = TournamentProcessor.new(@tournament)
    processor.play_division_games!

    redirect_to tournament_path(params[:tournament_id])
  end

  def generate_playoff_results
    @tournament = Tournament.find(params[:tournament_id])

    processor = TournamentProcessor.new(@tournament)
    processor.playoff!

    redirect_to tournament_path(params[:tournament_id])
  end
end
