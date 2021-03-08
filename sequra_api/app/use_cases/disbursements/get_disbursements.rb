module Disbursements
  class GetDisbursements
    include Caze

    attr_reader :data_result
    attr_accessor :week, :year, :merchant

    export :call, as: :get_disbursements

    def initialize(params)
      @data   = []
      @meta   = {}
      @errors = []
      @params = params
      @merchant = nil
    end

    def call
      begin
        calculate_week_and_year
        fetch_merchant
        fetch_disbursements
      rescue => e
        @errors << {error: e}
      end
      list_disbursements
      @data_result = DataResult.new(data: @data, meta: @meta, errors: @errors)
    end

    private

    def calculate_week_and_year
      date = params[:date]
      date = Time.zone.now.beginning_of_week - 1.day unless date.present?
      date = Date.parse(date.to_s)
      time_coordinates = GetWeekAndYear.new.call(date)
      @week = time_coordinates[:week]
      @year = time_coordinates[:year]
    end

    def fetch_merchant
      @merchant = if params[:id].present?
        merchant_repository.find_by_merchant_id(params[:id])
      end
    end

    def merchant_repository
      @merchant_repository ||= Merchants::MerchantRepository.new
    end

    def disbursement_repository
      @disbursement_repository ||= Disbursements::DisbursementRepository.new
    end

    def fetch_disbursements
      @data = disbursement_repository.get_disbursements(merchant, week, year)
    end

    def list_disbursements
      @meta["total_count"] = @data.as_json.size.to_i
    end

  end
end
