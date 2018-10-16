class Tournament < ApplicationRecord
  has_many :team_tournaments
  has_many :teams, -> { select('teams.*, team_tournaments.division as division, team_tournaments.division_winner as division_winner') }, through: :team_tournaments

  MAX_ALLOWED_TEAMS_IN_DIVISION_COUNT = 8.freeze
end
