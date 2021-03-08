module Merchants
  class MerchantRepository

    def find_by_id(id)
      Merchant.where(id: id).first
    end

    def find_by_merchant_id(id)
      Merchant.where(merchant_id: id).first
    end

  end
end
