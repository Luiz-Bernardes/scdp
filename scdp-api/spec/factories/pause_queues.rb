FactoryBot.define do
  factory :pause_queue do
    association :user
    association :team
    association :pause_type

    position { 1 }
    status { "waiting" }
    requested_at { Time.current }
    selected_duration_minutes { 10 }
  end
end