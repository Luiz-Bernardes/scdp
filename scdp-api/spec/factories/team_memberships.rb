FactoryBot.define do
  factory :team_membership do
    association :team
    association :user
    email { user.email }
    team_role { :member }
    pending { false }
  end
end