class AddDivisionWinnerToTeamTournaments < ActiveRecord::Migration[5.0]
  def change
    add_column :team_tournaments, :division_winner, :boolean, default: false, null: false
  end
end
