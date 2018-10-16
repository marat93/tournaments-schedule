class Tournament < ApplicationRecord
  has_many :team_tournaments
  has_many :teams, -> { select('teams.*, team_tournaments.division as division') }, through: :team_tournaments
end
