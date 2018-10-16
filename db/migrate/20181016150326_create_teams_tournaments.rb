class CreateTeamsTournaments < ActiveRecord::Migration[5.0]
  def change
    create_table :team_tournaments do |t|
      t.belongs_to :team
      t.belongs_to :tournament
      t.string     :division
      t.timestamps
    end
  end
end
