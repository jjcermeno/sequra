FactoryBot.define do
  factory :disbursement do
    total_amount           { 500.0 }
    total_fee              { total_amount * (0.85 / 100)}
    total_disbursement     { total_amount - total_fee }
    week { 8 }
    year { 2021 }
    transient do
      order { build(:order) }
      merchant { order.merchant }
    end
  end
end