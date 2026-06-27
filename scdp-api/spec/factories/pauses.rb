FactoryBot.define do
  factory :pause do
    association :user
    association :team
    association :pause_type

    selected_duration_minutes { 10 }
    started_at { Time.current }
    status { :active }
  end
end