FactoryGirl.define do
  factory :player do
    name "Kobe Bryant"
    twitter_handle "kobebryant"
    current_mentions 0

    factory :player_with_hourly_scores do
      transient do
        score_count 24
      end

      after(:create) do |player, evaluator|
        create_list(:hourly_score, 
                    evaluator.score_count,
                    player: player)
      end
    end

  end
end
