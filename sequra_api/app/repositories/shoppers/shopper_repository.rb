module Shoppers
  class ShopperRepository

    def find_by_id(id)
      Shopper.where(id: id).first
    end

    def find_by_shopper_id(id)
      Shopper.where(shopper_id: id).first
    end

    def create_or_update(dto)
      shopper = find_by_shopper_id(dto.shopper_id)
      shopper = Shopper.new unless shopper.present?
      shopper.shopper_id = dto.shopper_id
      shopper.name = dto.name
      shopper.email = dto.email
      shopper.nif = dto.nif
      shopper.save
      shopper
    end

  end
end
