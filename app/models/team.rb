class Team < ApplicationRecord
  has_many :tournaments, through: :teams_tournaments

  scope :division, -> (division_name) { where('division = ?', division_name) }
end
