module Api
  module V1
    class OrderPresenter < BasePresenter
      def as_json
        {
          "id":                 @resource.id,
          "external_order_id":  @resource.order_id,
          "disbursement_id":    @resource.disbursement.id,
          "merchant_id":        @resource.merchant.id,
          "merchant_name":      @resource.merchant.name,
          "merchant_email":     @resource.merchant.email,
          "shopper_id":         @resource.shopper.id,
          "shopper_name":       @resource.shopper.name,
          "shopper_email":      @resource.shopper.email,
          "createdAt":          datetime_to_string(@resource.created_at),
          "updatedAt":          datetime_to_string(@resource.updated_at),
          "completedAt":        datetime_to_string(@resource.completed_at),
          "completed":          @resource.completed,
          "amount":             @resource.amount,
          "fee":                @resource.fee,
          "disbursement":       @resource.disbursement,
          "week":               @resource.week,
          "year":               @resource.year
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
