module Shoppers
  class LoadShoppers
    include Caze

    attr_reader :file_path
    attr_accessor :shoppers

    export :call, as: :load_shoppers

    def initialize(file_path='dataset/shoppers.json')
      @file_path = file_path
    end

    def call
      load_json_file
      create_or_update_shoppers
    end

    private

    def load_json_file
      file = File.read(file_path)
      data = JSON.parse(file)
      @shoppers = data["RECORDS"]
    end

    def create_or_update_shoppers
      shoppers.each do |shop|
        dto = Shoppers::LoadShopperDto.from_json(shop)
        create_or_update_shopper(dto)
      end
    end

    def create_or_update_shopper(dto)
      @shopper = shopper_repository.create_or_update(dto)
    end

    def shopper_repository
      @shopper_repository ||= Shoppers::ShopperRepository.new
    end

  end
end
