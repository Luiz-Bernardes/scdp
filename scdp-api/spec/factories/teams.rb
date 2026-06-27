FactoryBot.define do
  factory :team do
    name { "Support Team" }
    active { true }
    association :created_by, factory: :user
  end
end