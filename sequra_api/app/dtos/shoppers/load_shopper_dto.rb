module Shoppers
  class LoadShopperDto

    attr_accessor :shopper_id, :name, :email, :nif

    def self.from_json(data)
      new_dto             = new
      new_dto.shopper_id = data["id"].to_s.downcase if data["id"]
      new_dto.name        = data["name"] if data["name"]
      new_dto.email       = data["email"] if data["email"]
      new_dto.nif         = data["nif"] if data["nif"]
      new_dto
    end
  end
end
