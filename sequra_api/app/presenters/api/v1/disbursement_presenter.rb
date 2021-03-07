module Api
  module V1
    class DisbursementPresenter < BasePresenter
      def as_json
        {
          "id":                 @resource.id,
          "merchant_id":        @resource.shopper.id,
          "merchant_name":      @resource.shopper.name,
          "merchant_email":     @resource.shopper.email,
          "total_amount":       @resource.amount,
          "total_fee":          @resource.fee,
          "total_disbursement": @resource.disbursement,
          "week":               @resource.week,
          "year":               @resource.year,
          "updatedAt":          datetime_to_string(@resource.updated_at),
        }.as_json
      end

      private

      def date_to_unix(date)
        return unless date
        date.to_time.to_i
      end

      def datetime_to_string(datetime)
        return unless datetime
        datetime.to_s
      end

    end
  end
end
