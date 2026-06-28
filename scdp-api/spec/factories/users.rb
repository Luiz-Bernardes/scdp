FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    provider_uid { SecureRandom.uuid }
    role { :agent }
  end
end