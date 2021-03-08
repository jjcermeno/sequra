class Order < ApplicationRecord
  belongs_to :merchant
  belongs_to :shopper
  belongs_to :disbursement

  monetize :amount,       as: "amount_money"
  monetize :fee,          as: "fee_money"
  monetize :disbursement, as: "disbursement_money"
end
