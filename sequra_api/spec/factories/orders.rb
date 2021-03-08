FactoryBot.define do
  # factory :merchant
  # factory :shopper

  factory :order do
    amount           { 500.0 }
    fee              { amount * (0.85 / 100)}
    disbursement     { amount - fee }
    week             { 8 }
    year             { 2021 }
    completed        { true }
    completed_at     { DateTime.parse('01/07/2017 14:24:01')}
    transient do
      merchant { build(:merchant) }
      shopper { build(:shopper) }
    end
  end
end
