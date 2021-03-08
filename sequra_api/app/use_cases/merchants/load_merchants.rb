module Merchants
  class LoadMerchants
    include Caze

    attr_reader :file_path
    attr_accessor :merchants

    export :call, as: :load_merchants

    def initialize(file_path='dataset/merchants.json')
      @file_path = file_path
    end

    def call
      load_json_file
      create_or_update_merchants
    end

    private

    def load_json_file
      file = File.read(file_path)
      data = JSON.parse(file)
      @merchants = data["RECORDS"]
    end

    def create_or_update_merchants
      merchants.each do |merch|
        dto = Merchants::LoadMerchantDto.from_json(merch)
        create_or_update_merchant(dto)
      end
    end

    def create_or_update_merchant(dto)
      @merchant = merchant_repository.create_or_update(dto)
    end

    def merchant_repository
      @merchant_repository ||= Merchants::MerchantRepository.new
    end

  end
end
