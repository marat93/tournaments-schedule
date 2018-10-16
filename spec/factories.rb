 FactoryBot.define do
  factory :team do
    name { Faker::Team.name }
  end

  factory :tournament do
    name { Faker::Name.name + ' Tournament' }

    trait :with_teams do
      after :create do |tournament|
        create_list :team_tournament, 8, :division_a, tournament: tournament
        create_list :team_tournament, 8, :division_b, tournament: tournament
      end
    end
  end

  factory :team_tournament do
    association :team
    association :tournament

    trait :division_a do
      division { TeamTournament::DIVISION_A }
    end

    trait :division_b do
      division { TeamTournament::DIVISION_B }
    end
  end
end
