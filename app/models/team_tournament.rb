class TeamTournament < ApplicationRecord
  belongs_to :team
  belongs_to :tournament

  DIVISION_A = "division A".freeze
  DIVISION_B = "division B".freeze
end
