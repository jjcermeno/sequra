module Api
  module V1
    class OrderPresenter < BasePresenter
      def as_json
        {
          "id":             @resource.id,
          "merchant_id":    @resource.merchant.id,
          "merchant_name":  @resource.merchant.name,
          "merchant_email": @resource.merchant.email,
          "shopper_id":     @resource.shopper.id,
          "shopper_name":   @resource.shopper.name,
          "shopper_email":  @resource.shopper.email,
          "amount":         @resource.amount,
          "fee":            @resource.fee,
          "disbursement":   @resource.disbursement,
          "week":           @resource.week,
          "year":           @resource.year,
          "completed":      @resource.completed,
          "completedAt":    datetime_to_string(@resource.completed_at),
          "createdAt":      datetime_to_string(@resource.created_at),
          "updatedAt":      datetime_to_string(@resource.updated_at)
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
