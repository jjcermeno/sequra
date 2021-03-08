module Merchants
  class MerchantRepository

    def find_by_id(id)
      Merchant.where(id: id).first
    end

    def find_by_merchant_id(id)
      Merchant.where(merchant_id: id).first
    end

    def create_or_update(dto)
      merchant = find_by_merchant_id(dto.merchant_id)
      merchant = Merchant.new unless merchant.present?
      merchant.merchant_id = dto.merchant_id
      merchant.name = dto.name
      merchant.email = dto.email
      merchant.cif = dto.cif
      merchant.save
      merchant
    end

  end
end
