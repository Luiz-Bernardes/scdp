FactoryBot.define do
  factory :pause_type do
    association :team
    name { "Intervalo" }
    has_time_limit { true }
    max_concurrent { 2 }
    requires_queue { true }
    active { true }
    max_duration_minutes { 120 }
  end
end