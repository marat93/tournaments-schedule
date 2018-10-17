class ChangePlaysTeamsColumnsNames < ActiveRecord::Migration[5.0]
  def change
    rename_column :plays, :team_a, :team_a_id
    rename_column :plays, :team_b, :team_b_id
  end
end
