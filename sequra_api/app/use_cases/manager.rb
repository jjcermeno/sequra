module Manager
  include Caze

  has_use_case :get_disbursements, Disbursements::GetDisbursements
  has_use_case :load_merchants, Merchants::LoadMerchants
  has_use_case :load_shoppers, Shoppers::LoadShoppers
end
