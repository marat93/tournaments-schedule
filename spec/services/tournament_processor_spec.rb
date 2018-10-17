require "rails_helper"

RSpec.describe TournamentProcessor do
  let (:tournament) { create :tournament, :with_teams }

  describe "#playoff!" do
    let(:num_of_unique_plays) { Play.select(:winner, :round).playoff.distinct.to_a.count }

    it "generate plays between teams in single-elimination manner" do
      processor = TournamentProcessor.new(tournament)
      processor.play_division_games!

      processor.playoff!

      expect(num_of_unique_plays).to eq(7)
    end
  end

  describe "#play_division_games!" do
    let(:num_of_unique_plays_in_division_a) { num_of_unique_plays(round: TeamTournament::DIVISION_A) }
    let(:num_of_unique_plays_in_division_b) { num_of_unique_plays(round: TeamTournament::DIVISION_B) }

    it "generates plays between teams in round robin manner in each division" do
      processor = TournamentProcessor.new(tournament)

      processor.play_division_games!

      expect(num_of_unique_plays_in_division_a).to eq(28)
      expect(num_of_unique_plays_in_division_b).to eq(28)
    end

    def num_of_unique_plays(round:)
      Play.select(:team_a_id, :team_b_id)
        .where(tournament: tournament, round: round)
        .distinct
        .to_a.count
    end
  end
end
