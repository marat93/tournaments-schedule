class CreatePlays < ActiveRecord::Migration[5.0]
  def change
    create_table :plays do |t|
      t.integer :tournament_id
      t.integer :team_a
      t.integer :team_b
      t.string  :round
      t.integer :winner
      t.timestamps
    end
  end
end
