class Disbursement < ApplicationRecord
  belongs_to :merchant
  has_many :orders

  monetize :total_amount,       as: "total_amount_money"
  monetize :total_fee,          as: "total_fee_money"
  monetize :total_disbursement, as: "total_disbursement_money"
end
