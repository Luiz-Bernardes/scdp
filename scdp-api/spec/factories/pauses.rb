FactoryBot.define do
  factory :pause do
    association :user
    association :team
    association :pause_type

    selected_duration_minutes { 10 }
    started_at { Time.current }
    status { :active }

    trait :active do
      status { :active }
      started_at { Time.current }
      selected_duration_minutes { 10 }
      expires_at { 10.minutes.from_now }
    end
  end
end