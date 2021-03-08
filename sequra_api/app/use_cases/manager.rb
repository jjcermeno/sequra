module Manager
  include Caze

  has_use_case :get_disbursements, Disbursements::GetDisbursements
end
