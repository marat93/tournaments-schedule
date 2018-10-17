class Play < ApplicationRecord
  belongs_to :tournament
  belongs_to :team_a, class_name: Team
  belongs_to :team_b, class_name: Team

  ONE_FOURTH  = '1/4'.freeze
  ONE_HALF    = '1/2'.freeze
  FINAL       = 'final'.freeze
  ROUND_NAMES = [ONE_FOURTH, ONE_HALF, FINAL].freeze

  scope :playoff, -> { where.not(round: [TeamTournament::DIVISION_A, TeamTournament::DIVISION_B]) }
  scope :playoff_first_round,  -> { where(round: ONE_FOURTH) }
  scope :playoff_second_round, -> { where(round: ONE_HALF) }
  scope :playoff_final_round,  -> { where(round: FINAL) }

  def winner?(team)
    winner == team.id
  end
end
