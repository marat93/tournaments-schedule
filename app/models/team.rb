class Team < ApplicationRecord
  has_many :tournaments, through: :teams_tournaments

  scope :division, -> (division_name) { where('division = ?', division_name) }
  scope :division_winners, -> (division_name) { where('division = ? AND division_winner = ?', division_name, true) }
end
