FactoryBot.define do
  factory :shopper do
    name        { Faker::Name.name }
    email       { Faker::Internet.email }
    nif         { '411111111Z' }
  end
end