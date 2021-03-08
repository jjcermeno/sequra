module Disbursements
  class DisbursementRepository

    def get_disbursements(merchant, week, year)
      disbursements = if merchant.present?
        get_disbursements_with_merchant_and_date(merchant, week, year)
      else
        get_disbursements_with_date(week, year)
      end
      CollectionPresenter.new(
        disbursements,
        Api::V1::DisbursementPresenter
      )
    end

    private

    def get_disbursements_with_merchant_and_date(merchant, week, year)
      Disbursement.where(merchant: merchant, week: week, year: year)
    end

    def get_disbursements_with_date(week, year)
      Disbursement.where(week: week, year: year)
    end

  end
end