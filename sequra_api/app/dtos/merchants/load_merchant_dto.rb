module Merchants
  class LoadMerchantDto

    attr_accessor :merchant_id, :name, :email, :cif

    def self.from_json(data)
      new_dto             = new
      new_dto.merchant_id = data["id"].to_s.downcase if data["id"]
      new_dto.name        = data["name"] if data["name"]
      new_dto.email       = data["email"] if data["email"]
      new_dto.cif         = data["cif"] if data["cif"]
      new_dto
    end
  end
end
