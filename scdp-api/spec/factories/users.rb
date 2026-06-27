FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    microsoft_uid { SecureRandom.uuid }
    role { :agent }
  end
end